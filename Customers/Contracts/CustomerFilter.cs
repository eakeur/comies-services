using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Comies.Contracts;

namespace Comies.Customers
{
    public class CustomerFilter : IFilter
    {
        public int Skip { get; set; }

        public string Name { get; set; }

        public string PhoneNumber { get; set; }
    }
}
