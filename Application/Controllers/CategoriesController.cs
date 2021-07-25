using Microsoft.AspNetCore.Mvc;
using System;
using System.Threading.Tasks;
using System.Collections.Generic;
using Comies;
using Comies.Products;
namespace Comies.Controllers
{
    [ApiController]
    [Route(("api/v1/categories"))]
    public class CategoriesController : BaseController<ProductCategory, CategoryView, CategoryFilter, ICategoriesService>
    {
        public CategoriesController(ICategoriesService service) : base(service) {}

    }
}