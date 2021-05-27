using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore;
using Comies;

namespace Comies.ModelsSettings
{   
    public class StorePropertiesConfiguration : IEntityTypeConfiguration<StoreProperty>{
        
        public void Configure(EntityTypeBuilder<StoreProperty> builder){
            builder.HasKey(p => p.Id);
            builder.HasIndex(i => new { i.Key, i.ParentId, i.StoreId }).IsUnique();
        }
    }
}