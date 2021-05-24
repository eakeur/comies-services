using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore;
using Comies.Structures.Models;

namespace Comies.Structures.ModelsConfigurations
{   
    public class CategoryConfiguration : IEntityTypeConfiguration<ProductCategory>{
        
        public void Configure(EntityTypeBuilder<ProductCategory> builder){
            builder.HasKey(cat => new { cat.Code, cat.StoreId });

            builder.Property(cat => cat.Code)
                .IsRequired(true)
                .HasMaxLength(6)
            ;

            builder.Property(cat => cat.StoreId)
                .IsRequired(true);

            builder.Property(cat => cat.Name)
                .IsRequired(true);
        }
    }
}