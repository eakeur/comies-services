using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore;
using Comies;

namespace Comies.ModelsSettings
{   
    public class OrderConfiguration : IEntityTypeConfiguration<Order>{
        
        public void Configure(EntityTypeBuilder<Order> builder){
            builder.HasKey(op => op.Id);

            builder.Property(op => op.Placed).IsRequired(true);

            builder.HasIndex(i => new { i.CustomerId, i.StoreId, i.Placed }).IsUnique();
        }
    }
}