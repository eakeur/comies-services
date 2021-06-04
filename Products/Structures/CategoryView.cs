using System;
using System.Collections.Generic;

namespace Comies.Products {
    public class CategoryView {
        public Guid Id { get; set; }
        public Guid Parent { get; set; }
        public string Code { get; set; }
        public string Name { get; set; }
        public List<ProductView> Products { get; set; }
    }
}