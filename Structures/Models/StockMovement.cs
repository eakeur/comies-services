using comies_services.Structures.Enumerators;
using System;
namespace comies_services.Structures.Models
{
    public class StockMovement : StoreOwnedEntity
    {
        public int Id { get; set; }
		public int StockId { get; set; }
		public StockMovementType Type { get; set; }
		public DateTime EffectiveDate { get; set; }
		public double Quantity { get; set; }
		public decimal UnityPrice { get; set; }
		public decimal OtherCosts { get; set; }
		public int OrderId { get; set; }
		public int SupplierId { get; set; }
		public string Document { get; set; }
		public string Observations { get; set; }

	}
}