using System;
namespace Comies
{
    public class Ingredient : StoreOwnedEntity
    {
        public Guid Id { get; set; }
        public Guid ProductId { get; set; }
        public Guid IngredientId { get; set; }
        public double Quantity { get; set; }
        public virtual Product Product { get; set; }
        public virtual Product Component { get; set; }

    }
}