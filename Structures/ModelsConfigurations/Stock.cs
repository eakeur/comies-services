using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore;
using Comies.Structures.Models;

namespace Comies.Structures.ModelsConfigurations
{   
    public class StockConfiguration : IEntityTypeConfiguration<Stock>{
        
        public void Configure(EntityTypeBuilder<Stock> builder){
            builder.HasKey(p => p.Id);
            builder.Property(p => p.Actual).IsRequired(true);
            builder.HasIndex(i => new { i.ProductId, i.StoreId }).IsUnique();
        }
    }
}