using Comies.Structures.Enumerators;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System;
namespace Comies.Structures.Models
{
    public class StockMovement : StoreOwnedEntity
    {
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)] 
		public Guid Id { get; set; }
		[Required]
		public Guid StockId { get; set; }
		
		[Required]
		public StockMovementType Type { get; set; }

		[Required]
		public DateTime EffectiveDate { get; set; }
		
		[Required]
		public double Quantity { get; set; }
		public decimal UnityPrice { get; set; }
		public decimal OtherCosts { get; set; }
		public Guid OrderId { get; set; }
		public Guid SupplierId { get; set; }

		[MaxLength(100)]
		public string Document { get; set; }

		[MaxLength(200)]
		public string Observations { get; set; }
		public Stock Stock { get; set; }

    }
}