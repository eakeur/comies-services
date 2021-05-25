using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore;
using Comies.Structures.Models;

namespace Comies.Structures.ModelsConfigurations
{   
    public class CategoryConfiguration : IEntityTypeConfiguration<ProductCategory>{
        
        public void Configure(EntityTypeBuilder<ProductCategory> builder){
            builder.HasKey(cat => cat.Id);

            builder.Property(cat => cat.Code).IsRequired(true).HasMaxLength(6);
            builder.Property(cat => cat.StoreId).IsRequired(true);
            builder.Property(cat => cat.Name).IsRequired(true);

            builder.HasMany(x => x.Children).WithOne(x => x.Parent).HasForeignKey(x => x.ParentId);
            builder.HasMany(x => x.Products).WithOne(x => x.Category).HasForeignKey(x => x.CategoryId);

            builder.HasIndex(i => new { i.Code, i.StoreId }).IsUnique();
        }
    }
}