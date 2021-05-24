using Comies.Structures.Enumerators;
using System.ComponentModel.DataAnnotations;

using System;
namespace Comies.Structures.Models
{
    public class StockMovement : StoreOwnedEntity
    {
        public int Id { get; set; }
		[Required]
		public int StockId { get; set; }
		
		[Required]
		public StockMovementType Type { get; set; }

		[Required]
		public DateTime EffectiveDate { get; set; }
		
		[Required]
		public double Quantity { get; set; }
		public decimal UnityPrice { get; set; }
		public decimal OtherCosts { get; set; }
		public int OrderId { get; set; }
		public int SupplierId { get; set; }
		public string Document { get; set; }
		public string Observations { get; set; }

	}
}