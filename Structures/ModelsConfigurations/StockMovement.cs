using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore;
using Comies.Structures.Models;

namespace Comies.Structures.ModelsConfigurations
{   
    public class StockMovementConfiguration : IEntityTypeConfiguration<StockMovement>{
        
        public void Configure(EntityTypeBuilder<StockMovement> builder){
            builder.HasKey(p => p.Id);
            builder.Property(p => p.StockId).IsRequired(true);
            builder.Property(p => p.Type).IsRequired(true);
            builder.Property(p => p.EffectiveDate).IsRequired(true);
            builder.Property(p => p.Quantity).IsRequired(true);
        }
    }
}