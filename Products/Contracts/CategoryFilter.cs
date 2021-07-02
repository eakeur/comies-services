using Comies.Contracts;
using System;

namespace Comies.Products
{
    public class CategoryFilter : IFilter {
        public string Description { get; set; }
        public int Skip { get; set; }
        public string Code { get; set; }
        public string Name { get; set; }
        public Guid ParentId { get; set; }

    }
}