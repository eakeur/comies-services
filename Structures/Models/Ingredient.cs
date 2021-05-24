using System.ComponentModel.DataAnnotations;
namespace Comies.Structures.Models
{
    public class Ingredient
    {
        public int Id { get; set; }
        public int ProductId { get; set; }
        public int IngredientId { get; set; }
        public double Quantity { get; set; }
        public Product Product { get; set; }
        public Product Component { get; set; }

    }
}