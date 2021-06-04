using Comies.Contracts;
using System;

namespace Comies.Products
{
    public interface IProductFilter : IFilter {
        Guid CategoryId { get; set; }
        string Code { get; set; }
        string Tag { get; set; }
        string Name { get; set; }

    }
}