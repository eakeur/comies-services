using comies_services.Structures.Enumerators;
using System.Collections.Generic;
using FluentValidator;
using System;
namespace comies_services.Structures.Models
{
    public class OrderItem : StoreOwnedEntity
    {
        public int Id { get; set; }
        public int OrderId { get; set; }
        public double Quantity { get; set; }
        public bool Done { get; set; }
        public decimal Discount { get; set; }
        public decimal Price { get; set; }
        public decimal FinalPrice { get; set; }
        public virtual Order Order { get; set; }
        public virtual ICollection<OrderComponent> OrderComponents { get; set; }
    }
}