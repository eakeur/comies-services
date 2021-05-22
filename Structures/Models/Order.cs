using comies_services.Structures.Enumerators;
using System.Collections.Generic;
using FluentValidator;
using System;
namespace comies_services.Structures.Models
{
    public class Order : StoreOwnedEntity
    {
        public int Id { get; set; }
        public DateTime Placed { get; set; }
        public Status Status { get; set; }
        public PaymentMethod PaymentMethod { get; set; }
        public DeliverType DeliverType { get; set; }
        public int AddressId { get; set; }
        public int CostumerId { get; set; }
        public int OperatorId { get; set; }
        public decimal Price { get; set; }
        public decimal FinalPrice { get; set; }
        public virtual Operator Operator { get; set; }
        public virtual Address Address { get; set; }
        public virtual Costumer Costumer { get; set; }
        public virtual ICollection<OrderItem> OrderItems { get; set; }

    }
}