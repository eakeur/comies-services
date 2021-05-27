using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore;
using Comies;

namespace Comies.ModelsSettings
{   
    public class SupplierConfiguration : IEntityTypeConfiguration<Supplier>{
        
        public void Configure(EntityTypeBuilder<Supplier> builder){
            builder.HasKey(p => p.Id);
        }
    }
}