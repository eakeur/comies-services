using System;
using System.Collections.Generic;
using System.Diagnostics.CodeAnalysis;

namespace Comies.Customers {
    public class CustomerView {
        public Guid Id { get; set; }
        public string Name { get; set; }
        public Phone Phone { get; set; }
    }

    class CustomerViewEqualityComparer : IEqualityComparer<CustomerView>
    {
        public bool Equals(CustomerView x, CustomerView y)
        {
            return x.Id == y.Id;
        }

        public int GetHashCode([DisallowNull] CustomerView obj)
        {
            return obj.Id.GetHashCode();
        }
    }

}