using Microsoft.AspNetCore.Mvc;
using Comies.Products;
using System;
using System.Threading.Tasks;
using System.Collections.Generic;
using Microsoft.AspNetCore.Authorization;

namespace Comies.Controllers
{
    [ApiController]
    [Route(("api/v1/products"))]
    [Authorize]
    public class ProductsController : BaseController<Product, ProductView, ProductFilter, IProductsService>
    {
        public ProductsController(IProductsService service) : base(service) {}

        #region Ingredient Endpoints

        [HttpGet("{productId}/ingredients")]
        public async Task<ActionResult<IEnumerable<Ingredient>>> GetSomeIngredients(Guid productId)
        {
            return await base.SendSome<Ingredient>(() => Service.GetIngredients(productId));
        }
        

        [HttpPost("{productId}/ingredients")]
        public async Task<ActionResult<Ingredient>> SaveIngredient(Guid productId, Ingredient structure)
        {
            return await base.SaveSent<Ingredient>(() => Service.AddIngredient(structure, productId), "GetIngredient", (p) => new { id = p.Id, productId = p.ProductId});
        }

        [HttpGet("{productId}/ingredients/{id}")]
        public async Task<ActionResult<Ingredient>> GetIngredient(Guid productId, Guid id)
        {
            return await base.SendOne<Ingredient>(() => Service.GetIngredient(id, productId));
        }

        [HttpDelete("{productId}/ingredients/{id}")]
        public async Task<IActionResult> RemoveIngredient(Guid productId, Guid id)
        {
            return await base.RemoveSent(() =>  Service.RemoveIngredient(id, productId));
        }

        [HttpPut("{productId}/ingredients/{id}")]
        public async Task<IActionResult> UpdateIngredient(Guid productId, Guid id, Ingredient entity)
        {
            return await base.UpdateSent(() => Service.UpdateIngredient(id, entity, productId));
        }

        #endregion
    }
}