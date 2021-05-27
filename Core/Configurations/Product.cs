using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore;

namespace Comies.ModelsSettings
{   
    public class ProductConfiguration : IEntityTypeConfiguration<Product>{
        
        public void Configure(EntityTypeBuilder<Product> builder){
            builder.HasKey(op => op.Id);
            builder.Property(p => p.StoreId).IsRequired(true);
            builder.HasMany(p => p.Orders).WithOne(p => p.Product).HasForeignKey(x => x.ProductId);
            builder.HasMany(p => p.Ingredients).WithOne(p => p.Product).HasForeignKey(p => p.ProductId);
            builder.HasMany(p => p.Featuring).WithOne(p => p.Component).HasForeignKey(p => p.IngredientId);
            builder.Property(p => p.Minimum).HasDefaultValue(1);
            builder.HasIndex(i => new { i.Code, i.StoreId }).IsUnique();
        }
    }
}