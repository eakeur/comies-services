using comies_services.Structures.Enumerators;
using FluentValidator;
namespace comies_services.Structures.Models
{
    public class Ingredient : Notifiable
    {
        public int Id { get; set; }
        public int ProductId { get; set; }
        public int IngredientId { get; set; }
        public double Quantity { get; set; }
        public virtual Product Product { get; set; }
        public virtual Product Component { get; set; }

    }
}