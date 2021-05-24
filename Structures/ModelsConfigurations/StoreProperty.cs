using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore;
using Comies.Structures.Models;

namespace Comies.Structures.ModelsConfigurations
{   
    public class StorePropertiesConfiguration : IEntityTypeConfiguration<StoreProperty>{
        
        public void Configure(EntityTypeBuilder<StoreProperty> builder){
            builder.HasKey(p => new {p.ParentId, p.Key, p.StoreId});
        }
    }
}