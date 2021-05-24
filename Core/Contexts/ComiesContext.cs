using Microsoft.EntityFrameworkCore;
using Comies.Structures.ModelsConfigurations;
using System.Linq;

using Comies.Structures.Models;

namespace Comies.Core.Contexts {
    public class ComiesContext : DbContext {

        protected override void OnModelCreating(ModelBuilder builder)
        {
            builder.ApplyConfiguration<Address>(new AddressConfiguration());
            builder.ApplyConfiguration<ProductCategory>(new CategoryConfiguration());
            builder.ApplyConfiguration<Costumer>(new CostumerConfiguration());
            builder.ApplyConfiguration<Ingredient>(new IngredientConfiguration());
            builder.ApplyConfiguration<Operator>(new OperatorConfiguration());
            builder.ApplyConfiguration<Order>(new OrderConfiguration());
            builder.ApplyConfiguration<OrderItem>(new OrderItemConfiguration());
            builder.ApplyConfiguration<Phone>(new PhoneConfiguration());
            builder.ApplyConfiguration<Product>(new ProductConfiguration());
            builder.ApplyConfiguration<Profile>(new ProfileConfiguration());
            builder.ApplyConfiguration<ProfileDetails>(new ProfileDetailsConfiguration());
            builder.ApplyConfiguration<Stock>(new StockConfiguration());
            builder.ApplyConfiguration<StockMovement>(new StockMovementConfiguration());
            builder.ApplyConfiguration<Store>(new StoreConfiguration());
            builder.ApplyConfiguration<StoreProperty>(new StorePropertiesConfiguration());
            builder.ApplyConfiguration<Supplier>(new SupplierConfiguration());

            foreach (var entity in builder.Model.GetEntityTypes()){
                foreach(var fk in entity.GetForeignKeys()){
                    fk.DeleteBehavior = DeleteBehavior.NoAction;
                }
            }
        }
        public DbSet<Address> Addresses { get; set; }
        public DbSet<ProductCategory> ProductsCategories { get; set; }
        public DbSet<Costumer> Costumers { get; set; }
        public DbSet<Ingredient> Ingredients { get; set; }
        public DbSet<Operator> Operators { get; set; }
        public DbSet<Order> Orders { get; set; }
        public DbSet<OrderItem> OrdersItems { get; set; }
        public DbSet<Phone> Phones { get; set; }
        public DbSet<Product> Products { get; set; }
        public DbSet<Profile> Profiles { get; set; }
        public DbSet<ProfileDetails> ProfilesDetails { get; set; }
        public DbSet<Stock> Stocks { get; set; }
        public DbSet<StockMovement> StocksMovements { get; set; }
        public DbSet<Store> Stores { get; set; }
        public DbSet<StoreProperty> StoresProperties { get; set; }
        public DbSet<Supplier> Suppliers { get; set; }

        public ComiesContext(DbContextOptions<ComiesContext> options) : base(options){

        }

    }
}