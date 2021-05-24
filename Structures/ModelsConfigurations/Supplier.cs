using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore;
using Comies.Structures.Models;

namespace Comies.Structures.ModelsConfigurations
{   
    public class SupplierConfiguration : IEntityTypeConfiguration<Supplier>{
        
        public void Configure(EntityTypeBuilder<Supplier> builder){
            builder.HasKey(p => new {p.Id, p.StoreId});
        }
    }
}