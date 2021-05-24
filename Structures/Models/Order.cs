using Comies.Structures.Enumerators;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System;
namespace Comies.Structures.Models
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
        public Operator Operator { get; set; }
        public Address Address { get; set; }
        public Costumer Costumer { get; set; }
        public virtual IList<OrderItem> OrderItems { get; set; }

    }
}