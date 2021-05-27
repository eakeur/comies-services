using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore;
using Comies;

namespace Comies.ModelsSettings
{   
    public class PhoneConfiguration : IEntityTypeConfiguration<Phone>{
        
        public void Configure(EntityTypeBuilder<Phone> builder){
            builder.HasKey(p => p.Id);
            
            builder.Property(op => op.DDD).HasMaxLength(3);
            builder.Property(op => op.Number).IsRequired(true).HasMaxLength(9);
        }
    }
}