using Comies.Contracts;
using System;

namespace Comies.Products
{
    public class ProductFilter : IFilter {
        public Guid CategoryId { get; set; }
        public int Skip { get; set; }
        public string Code { get; set; }
        public string Tag { get; set; }
        public string Name { get; set; }

    }
}