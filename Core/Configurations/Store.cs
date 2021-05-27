using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore;
using Comies;

namespace Comies.ModelsSettings
{   
    public class StoreConfiguration : IEntityTypeConfiguration<Store>{
        
        public void Configure(EntityTypeBuilder<Store> builder){
            builder.HasKey(p => p.Id);
        }
    }
}