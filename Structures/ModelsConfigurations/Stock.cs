using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore;
using Comies.Structures.Models;

namespace Comies.Structures.ModelsConfigurations
{   
    public class StockConfiguration : IEntityTypeConfiguration<Stock>{
        
        public void Configure(EntityTypeBuilder<Stock> builder){
            builder.HasKey(p => new {p.ProductId, p.StoreId});
            builder.Property(p => p.Actual).IsRequired(true);
        }
    }
}