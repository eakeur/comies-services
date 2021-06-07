using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Comies.Products;


namespace Comies.Controllers
{
    [Route("api/v1/products")]
    [ApiController]
    [Authorize]
    public class ProductsController : ControllerBase
    {
        private readonly IProductsService Service;


        public ProductsController(IProductsService service)
        {
            Service = service; 
        }


        [HttpGet]
        public ActionResult<IEnumerable<CategoryView>> GetProducts([FromQuery] ProductFilter filters)
        {
            try
            {
                var products = Service.GetSome(filters); if (products == null) return NotFound();
                Utils.SetTotalCountHeaders(Response, products.Count());
                return Ok(products);
            }
            catch (ComiesArgumentException ex)
            {
                return BadRequest(ex.Message);
            }
            catch (System.Exception e)
            {
                return BadRequest(e.Message);
            }
        }


        [HttpGet("{id}")]
        public ActionResult<CategoryView> GetProduct(Guid id)
        {
            try
            {
                var product = Service.GetOne(id);
                if (product == null) return NotFound();
                return Ok(product);
            }
            catch (ComiesArgumentException ex)
            {
                return BadRequest(ex.Message);
            }
            catch (System.Exception)
            {
                throw new Exception();
            }
        }


        [HttpPut("{id}")]
        public IActionResult PutProduct(Guid id, Product product)
        {
            try
            {
                if (id != product.Id) return BadRequest();
                Service.Update(id, product);
                return NoContent();
            }
            catch (ComiesArgumentException ex)
            {
                return BadRequest(ex.Message);
            }
            catch (System.Exception)
            {
                throw new Exception();
            }
        }


        [HttpPost]
        public IActionResult PostProduct(Product product)
        {
            try
            {
                product = Service.Save(product);
                return CreatedAtAction("GetProduct", new { id = product.Id }, product);
            }
            catch (System.Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }


        [HttpDelete("{id}")]
        public IActionResult DeleteProduct(Guid id)
        {
            try
            {
                var product = Service.GetOne(id);
                if (product == null) return NotFound();
                Service.Remove(id); return NoContent();
            }
            catch (ComiesArgumentException ex)
            {
                return BadRequest(ex.Message);
            }
            catch (System.Exception)
            {
                throw new Exception();
            }
            
        }
    }
}
