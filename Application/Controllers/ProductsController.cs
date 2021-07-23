using Microsoft.AspNetCore.Mvc;
using Comies.Products;
namespace Comies.Controllers
{
    [ApiController]
    [Route(("api/v1/products"))]
    public class ProductsController : BaseController<Product, ProductView, ProductFilter, IProductsService>
    {
        public ProductsController(IProductsService service) : base(service) {}
    }
}