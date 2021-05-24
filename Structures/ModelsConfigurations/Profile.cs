using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore;
using Comies.Structures.Models;

namespace Comies.Structures.ModelsConfigurations
{   
    public class ProfileConfiguration : IEntityTypeConfiguration<Profile>{
        
        public void Configure(EntityTypeBuilder<Profile> builder){
            builder.HasKey(p => p.Id);
            builder.Property(p => p.ProfileName).IsRequired(true);
        }
    }
}