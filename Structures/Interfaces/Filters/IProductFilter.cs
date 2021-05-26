using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Comies.Structures.Local.Filters
{
    public interface IProductFilter : IFilter
    {
        int CategoryId { get; set; }
        string ProductCode { get; set; }
        string ProductName { get; set; }

    }
}
