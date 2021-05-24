using System.ComponentModel.DataAnnotations;
using System.Collections.Generic;
namespace Comies.Structures.Models
{
    public class OrderItem : StoreOwnedEntity
    {
        public int Id { get; set; }

        [Required]
        public int OrderId { get; set; }

        [Required]
        public int Group { get; set; }
        public double Quantity { get; set; }
        public bool Done { get; set; }
        public decimal Discount { get; set; }
        public decimal Price { get; set; }
        public decimal FinalPrice { get; set; }
        [Required]
        public int ProductId { get; set; }
        public Product Product { get; set; }
        public Order Order { get; set; }
    }
}