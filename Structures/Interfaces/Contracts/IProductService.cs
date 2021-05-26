using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Comies.Structures.Models;
using Comies.Structures.Local.Filters;

namespace Comies.Structures.Local.Contracts
{
    public interface IProductService : IService<Product, IProductFilter>
    {
        bool ExistsId(Guid id);
        bool ExistsCode(string code);
    }
}
