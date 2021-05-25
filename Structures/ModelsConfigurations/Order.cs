using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore;
using Comies.Structures.Models;

namespace Comies.Structures.ModelsConfigurations
{   
    public class OrderConfiguration : IEntityTypeConfiguration<Order>{
        
        public void Configure(EntityTypeBuilder<Order> builder){
            builder.HasKey(op => op.Id);

            builder.Property(op => op.Placed).IsRequired(true);
            builder.Property(op => op.CostumerId).IsRequired(true);
            builder.Property(op => op.AddressId).IsRequired(true).HasMaxLength(10);

            builder.HasIndex(i => new { i.CostumerId, i.StoreId, i.Placed }).IsUnique();
        }
    }
}