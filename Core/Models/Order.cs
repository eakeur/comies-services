using Comies;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System;
using System.ComponentModel.DataAnnotations.Schema;
namespace Comies
{
    public class Order : StoreOwnedEntity
    {
        
        public DateTime Placed { get; set; }
        public Status Status { get; set; }
        public PaymentMethod PaymentMethod { get; set; }
        public DeliverType DeliverType { get; set; }
        public Guid? AddressId { get; set; }
        public Guid? CustomerId { get; set; }
        public string CustomerName { get; set; }
        public Guid OperatorId { get; set; }
        public decimal Price { get; set; }
        public decimal FinalPrice { get; set; }
        public virtual Operator Operator { get; set; }
        public virtual Address Address { get; set; }
        public virtual Customer Costumer { get; set; }
        public virtual IList<OrderItem> OrderItems { get; set; }

    }
}