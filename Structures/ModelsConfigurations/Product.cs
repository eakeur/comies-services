using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore;
using Comies.Structures.Models;

namespace Comies.Structures.ModelsConfigurations
{   
    public class ProductConfiguration : IEntityTypeConfiguration<Product>{
        
        public void Configure(EntityTypeBuilder<Product> builder){
            builder.HasKey(op => new { op.Code, op.StoreId });
            
            builder.Property(p => p.Code).HasMaxLength(6);
            builder.Property(p => p.StoreId).IsRequired(true).HasMaxLength(9);
        }
    }
}