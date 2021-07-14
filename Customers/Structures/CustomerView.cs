using System;
using System.Collections.Generic;

namespace Comies.Customers {
    public class CustomerView {
        public Guid Id { get; set; }
        public string Name { get; set; }
        public Phone Phone { get; set; }
    }
}