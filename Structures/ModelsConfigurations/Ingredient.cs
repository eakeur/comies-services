using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore;
using Comies.Structures.Models;

namespace Comies.Structures.ModelsConfigurations
{   
    public class IngredientConfiguration : IEntityTypeConfiguration<Ingredient>{
        
        public void Configure(EntityTypeBuilder<Ingredient> builder){
            builder.HasKey(ing => new { ing.ProductId, ing.IngredientId,  });

            builder.Property(ing => ing.ProductId)
                .IsRequired(true)
            ;

            builder.Property(ing => ing.IngredientId)
                .IsRequired(true);
        }
    }
}