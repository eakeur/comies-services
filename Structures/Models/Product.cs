using Comies.Structures.Enumerators;
using System.ComponentModel.DataAnnotations;
namespace Comies.Structures.Models
{
    public class Product : StoreOwnedEntity
    {
        public int Id { get; set; }
        public string Code { get; set; }
        public string Name { get; set; }
        public string Display { get; set; }
        public string Description { get; set; }
        public Unity SellUnity { get; set; }
        public double Minimum { get; set; }
        public string Tags { get; set; }
        public decimal Discount { get; set; }
        public decimal Price { get; set; }
        public decimal Value { get; set; }
        public int ComboId { get; set; }
        public virtual Product Combo { get; set; }
        public ProductType Type { get; set; }

    }
}