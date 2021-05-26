using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Comies.Structures.Local.Filters
{
    public interface IFilter
    {
        int Skip { get; set; }
        int Take { get; set; }
    }
}
