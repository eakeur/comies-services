using Microsoft.EntityFrameworkCore;
using Comies.ModelsSettings;

namespace Comies {
    public class ComiesContext : DbContext {

        public ComiesContext(DbContextOptions<ComiesContext> options) : base(options){
        }

        protected override void OnModelCreating(ModelBuilder builder)
        {
            builder.ApplyConfiguration(new AddressConfiguration());
            builder.ApplyConfiguration(new CategoryConfiguration());
            builder.ApplyConfiguration(new CustomerConfiguration());
            builder.ApplyConfiguration(new IngredientConfiguration());
            builder.ApplyConfiguration(new OperatorConfiguration());
            builder.ApplyConfiguration(new OrderConfiguration());
            builder.ApplyConfiguration(new OrderItemConfiguration());
            builder.ApplyConfiguration(new PhoneConfiguration());
            builder.ApplyConfiguration(new ProductConfiguration());
            builder.ApplyConfiguration(new ProfileConfiguration());
            builder.ApplyConfiguration(new StockConfiguration());
            builder.ApplyConfiguration(new StockMovementConfiguration());
            builder.ApplyConfiguration(new StoreConfiguration());
            builder.ApplyConfiguration(new StorePropertiesConfiguration());

            

            foreach (var entity in builder.Model.GetEntityTypes()){
                foreach(var fk in entity.GetForeignKeys()){
                    fk.DeleteBehavior = DeleteBehavior.NoAction;
                }
            }
        }
        public DbSet<Address> Addresses { get; set; }
        public DbSet<ProductCategory> ProductsCategories { get; set; }
        public DbSet<Customer> Customers { get; set; }
        public DbSet<Ingredient> Ingredients { get; set; }
        public DbSet<Operator> Operators { get; set; }
        public DbSet<Order> Orders { get; set; }
        public DbSet<OrderItem> OrdersItems { get; set; }
        public DbSet<Phone> Phones { get; set; }
        public DbSet<Product> Products { get; set; }
        public DbSet<Profile> Profiles { get; set; }
        public DbSet<Stock> Stocks { get; set; }
        public DbSet<StockMovement> StocksMovements { get; set; }
        public DbSet<Store> Stores { get; set; }
        public DbSet<StoreProperty> StoresProperties { get; set; }

    }
}