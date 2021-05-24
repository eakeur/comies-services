using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore;
using Comies.Structures.Models;

namespace Comies.Structures.ModelsConfigurations
{   
    public class ProfileDetailsConfiguration : IEntityTypeConfiguration<ProfileDetails>{
        
        public void Configure(EntityTypeBuilder<ProfileDetails> builder){
            builder.HasKey(p => new { p.ProfileId, p.PermissionCode, p.StoreId});
        }
    }
}