using System;

namespace Comies.Products {
    public class ProductView
    {
        public Guid Id { get; set; }
        public string Code { get; set; }
        public string Name { get; set; }
        public decimal Value { get; set; }
        public Guid? CategotyId { get; set; }
        public double? StockLevel { get; set; }
        public String CategoryName { get; set; }
}
}