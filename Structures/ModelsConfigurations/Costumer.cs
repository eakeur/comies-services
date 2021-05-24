using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore;
using Comies.Structures.Models;

namespace Comies.Structures.ModelsConfigurations
{   
    public class CostumerConfiguration : IEntityTypeConfiguration<Costumer>{

        public void Configure(EntityTypeBuilder<Costumer> builder)
        {
            builder.HasKey(cos => cos.Id);

            builder.Property(cat => cat.Name)
                .IsRequired(true);
        }
    }
}