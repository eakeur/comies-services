using Microsoft.AspNetCore.Mvc;
using Comies.Products;
namespace Comies.Controllers
{
    [ApiController]
    [Route(("api/v1/categories"))]
    public class CategoriesController : BaseController<ProductCategory, CategoryView, CategoryFilter>
    {
        public CategoriesController(ICategoriesService service) : base(service) {}
    }
}