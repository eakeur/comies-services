using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore;
using Comies;

namespace Comies.ModelsSettings
{   
    public class IngredientConfiguration : IEntityTypeConfiguration<Ingredient>{
        
        public void Configure(EntityTypeBuilder<Ingredient> builder){
            builder.HasKey(ing => ing.Id);
            builder.Property(ing => ing.ProductId)
                .IsRequired(true)
            ;

            builder.Property(ing => ing.IngredientId)
                .IsRequired(true);

            builder.HasIndex(i => new { i.ProductId, i.IngredientId, i.StoreId }).IsUnique();

        }
    }
}