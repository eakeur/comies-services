using comies_services.Structures.Enumerators;
using System;
namespace comies_services.Structures.Models
{
    public class Stock : StoreOwnedEntity
    {
        public int Id { get; set; }
        public int ProductId { get; set; }
		public DateTime Date { get; set; }
		public double Minimum { get; set; }
		public double Maximum { get; set; }
		public double Actual { get; set; }
		public string Location { get; set; }
		public Unity StockUnity { get; set; }
		public int MainSupplierId { get; set; }

	}
}