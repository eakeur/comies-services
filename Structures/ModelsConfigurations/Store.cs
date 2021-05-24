using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore;
using Comies.Structures.Models;

namespace Comies.Structures.ModelsConfigurations
{   
    public class StoreConfiguration : IEntityTypeConfiguration<Store>{
        
        public void Configure(EntityTypeBuilder<Store> builder){
            builder.HasKey(p => p.Id);
            
        }
    }
}