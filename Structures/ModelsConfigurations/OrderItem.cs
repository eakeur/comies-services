using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore;
using Comies.Structures.Models;

namespace Comies.Structures.ModelsConfigurations
{   
    public class OrderItemConfiguration : IEntityTypeConfiguration<OrderItem>{
        
        public void Configure(EntityTypeBuilder<OrderItem> builder){
            builder.HasKey(op => op.Id);
            builder.Property(op => op.OrderId).IsRequired(true);
            builder.Property(op => op.ProductId).IsRequired(true);
            builder.Property(op => op.StoreId).IsRequired(true);
            builder.Property(op => op.Group).IsRequired(true);

            builder.HasIndex(i => new { i.OrderId, i.StoreId, i.ProductId, i.Group }).IsUnique();
        }
    }
}