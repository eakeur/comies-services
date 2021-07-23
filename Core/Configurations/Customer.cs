using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore;
using Comies;

namespace Comies.ModelsSettings
{   
    public class CustomerConfiguration : IEntityTypeConfiguration<Customer>{

        public void Configure(EntityTypeBuilder<Customer> builder)
        {
            builder.HasKey(cos => cos.Id);

            builder.Property(cat => cat.Name)
                .IsRequired(true);

            builder.HasIndex(i => new { i.Id, i.StoreId }).IsUnique();

            builder.HasMany(x => x.Addresses).WithOne(x => x.Costumer).HasForeignKey(x => x.CustomerId);
        }
    }
}