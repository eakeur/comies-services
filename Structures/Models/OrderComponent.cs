using comies_services.Structures.Enumerators;
using FluentValidator;
using System;
namespace comies_services.Structures.Models
{
    public class OrderComponent : StoreOwnedEntity
    {
        public int Id { get; set; }
        public int ItemId { get; set; }
        public int ProductId { get; set; }
        public double Quantity { get; set; }
        public bool Done { get; set; }
        public virtual OrderItem OrderItem { get; set; }
        public virtual Product Product { get; set; }

    }
}