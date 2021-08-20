using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore;
using Comies;

namespace Comies.ModelsSettings
{   
    public class StockConfiguration : IEntityTypeConfiguration<Stock>{
        
        public void Configure(EntityTypeBuilder<Stock> builder){
            builder.HasKey(p => p.Id);
            builder.Property(p => p.Actual).IsRequired(true);
            builder.HasIndex(i => new { i.Id, i.StoreId }).IsUnique();
        }
    }
}