using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore;
using Comies;

namespace Comies.ModelsSettings
{   
    public class AddressConfiguration : IEntityTypeConfiguration<Address>{
        
        public void Configure(EntityTypeBuilder<Address> builder){
            builder.HasKey(addr => addr.Id);
            builder.Property(addr => addr.CEP).IsRequired(true).HasMaxLength(8);
            builder.Property(addr => addr.Number).IsRequired(true);
            
        }
    }
}