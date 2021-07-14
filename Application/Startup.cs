using System;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Cors;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Authorization;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Options;
using Microsoft.OpenApi.Models;
using Comies.Auth;
using Comies.Products;
using Comies.Contracts;
namespace Comies
{
    public class Startup
    {
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {
            services.AddCors(cors => {
                cors.AddPolicy("AllowOrigin", (cfg) => cfg.AllowAnyOrigin());

                cors.AddPolicy("AllowMethod", (cfg) => cfg.AllowAnyMethod());

                cors.AddPolicy("AllowHeadder", (cfg) => cfg.AllowAnyHeader());

                cors.AddPolicy("ExposeHeaders", (cfg) => cfg.WithExposedHeaders("*"));
            });
            
            services.AddControllers();
            
            services.AddDbContext<ComiesContext>(o => {o.UseSqlServer("name=LocalComiesDBConn", b => b.MigrationsAssembly("ComiesAPI")); o.ConfigureWarnings(p => p. Ignore(30000));});
            services.AddSwaggerGen(c => c.SwaggerDoc("v1", new OpenApiInfo { Title = "comies_services", Version = "v1" }));
            services.AddIdentity<ApplicationUser, IdentityRole>()
                .AddEntityFrameworkStores<ComiesContext>()
                .AddDefaultTokenProviders();

            var signingConfigurations = new SigningConfigurations(Configuration["TokenConfigurations:securityKey"]);
            services.AddSingleton(signingConfigurations);

            var tokenConfigurations = new AuthenticationConfiguration();
            new ConfigureFromConfigurationOptions<AuthenticationConfiguration>(Configuration.GetSection("TokenConfigurations")).Configure(tokenConfigurations);
            services.AddSingleton(tokenConfigurations);

            services.AddAuthentication(authOptions =>
            {
                authOptions.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
                authOptions.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
                

            }).AddJwtBearer(jwtBearerOptions =>
            {
                jwtBearerOptions.RequireHttpsMetadata = false;
                jwtBearerOptions.SaveToken = true;
                var paramsValidation = jwtBearerOptions.TokenValidationParameters;

                paramsValidation.IssuerSigningKey = signingConfigurations.Key;
                paramsValidation.ValidAudience = tokenConfigurations.Audience;
                paramsValidation.ValidIssuer = tokenConfigurations.Issuer;

                paramsValidation.ValidateIssuerSigningKey = true;

                paramsValidation.ValidateLifetime = true;

                paramsValidation.ClockSkew = TimeSpan.Zero;
            });

            // Ativa o uso do token como forma de autorizar o acesso
            // a recursos deste projeto
            services.AddAuthorization(auth =>
            {
                
                auth.AddPolicy("Bearer", new AuthorizationPolicyBuilder()
                    .AddAuthenticationSchemes(JwtBearerDefaults.AuthenticationScheme)
                    .RequireAuthenticatedUser().Build());
            });


            

            services.AddTransient<IAuthenticatedOperator, AuthenticatedOperator>();

            services.AddScoped<AuthenticationService>();
            services.AddTransient<UserManager<ApplicationUser>>();
            services.AddTransient<SignInManager<ApplicationUser>>();

            services.AddTransient<IProductsService, ProductsService>();
            services.AddTransient<ICategoriesService, CategoriesService>();
            services.AddTransient<IStocksService, StocksService>();

            
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
                app.UseSwagger();
                app.UseSwaggerUI(c => c.SwaggerEndpoint("/swagger/v1/swagger.json", "comies_services v1"));
            }
            app.UseHttpsRedirection();

            app.UseRouting();
            app.UseStaticFiles();
            app.UseCors(options => {
                options.AllowAnyOrigin(); options.AllowAnyHeader(); options.AllowAnyMethod();
            });
            app.UseAuthentication();
            app.UseAuthorization();

            app.UseEndpoints(endpoints =>
            {
                endpoints.MapControllers();
            });
        }
    }
}
