using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Comies.Contracts;

namespace Customers.Contracts
{
    class CustomerFilter : IFilter
    {
        public int Skip { get; set; }
    }
}
