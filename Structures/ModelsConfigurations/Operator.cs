using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore;
using Comies.Structures.Models;

namespace Comies.Structures.ModelsConfigurations
{   
    public class OperatorConfiguration : IEntityTypeConfiguration<Operator>{
        
        public void Configure(EntityTypeBuilder<Operator> builder){
            builder.HasKey(op => op.Id);

            builder.Property(op => op.Name).IsRequired(true);
            builder.Property(op => op.Password).IsRequired(true);
            builder.Property(op => op.Nickname).IsRequired(true)
                .HasMaxLength(10);

            builder.HasIndex(i => new { i.Nickname, i.StoreId }).IsUnique();
        }
    }
}