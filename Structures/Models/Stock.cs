using Comies.Structures.Enumerators;
using System.Collections.Generic;
using System;
using System.ComponentModel.DataAnnotations.Schema;
namespace Comies.Structures.Models
{
    public class Stock : StoreOwnedEntity
    {
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)] 
		public Guid Id { get; set; }
        public Guid ProductId { get; set; }
		public DateTime Date { get; set; }
		public double Minimum { get; set; }
		public double Maximum { get; set; }
		public double Actual { get; set; }
		public string Location { get; set; }
		public Unity StockUnity { get; set; }
		public Guid MainSupplierId { get; set; }
        public virtual IList<StockMovement> Movements { get; set; }

    }
}