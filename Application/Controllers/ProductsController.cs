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
        private readonly IProductsService ProductsService;

        private readonly ICategoriesService CategoriesService;


        public ProductsController(IProductsService productsService, ICategoriesService categoriesService)
        {
            ProductsService = productsService; CategoriesService = categoriesService;
        }


        [HttpGet]
        public ActionResult<IEnumerable<ProductView>> GetProducts([FromQuery] ProductFilter filters)
        {
            try
            {
                var products = ProductsService.GetSome(filters); if (products == null) return NotFound();
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

        [HttpPost]
        public IActionResult PostProduct(Product product)
        {
            try
            {
                product = ProductsService.Save(product);
                return CreatedAtAction("GetProduct", new { id = product.Id }, product);
            }
            catch (System.Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [HttpGet("{id}")]
        public ActionResult<Product> GetProduct(Guid id)
        {
            try
            {
                var product = ProductsService.GetOne(id);
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
                ProductsService.Update(id, product);
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

        [HttpDelete("{id}")]
        public IActionResult DeleteProduct(Guid id)
        {
            try
            {
                var product = ProductsService.GetOne(id);
                if (product == null) return NotFound();
                ProductsService.Remove(id); return NoContent();
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

        [HttpGet("categories")]
        public ActionResult<IEnumerable<CategoryView>> GetCategories([FromQuery] CategoryFilter filters)
        {
            try
            {
                var categories = CategoriesService.GetSome(filters); if (categories == null) return NotFound();
                Utils.SetTotalCountHeaders(Response, categories.Count());
                return Ok(categories);
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

        [HttpPost("categories")]
        public IActionResult PostCategory(ProductCategory category)
        {
            try
            {
                category = CategoriesService.Save(category);
                return CreatedAtAction("GetCategory", new { id = category.Id }, category);
            }
            catch (System.Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }
        
        [HttpGet("categories/{id}")]
        public ActionResult<Product> GetCategory(Guid id)
        {
            try
            {
                var category = CategoriesService.GetOne(id);
                if (category == null) return NotFound();
                return Ok(category);
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

        [HttpPut("categories/{id}")]
        public IActionResult PutCategory(Guid id, ProductCategory category)
        {
            try
            {
                if (id != category.Id) return BadRequest("Ops! Você não pode alterar o código identificador de um item");
                CategoriesService.Update(id, category);
                return NoContent();
            }
            catch (ComiesArgumentException ex)
            {
                return BadRequest(ex.Message);
            }
            catch (System.Exception)
            {
                throw new Exception("Ops! Um erro inesperado ocorreu.");
            }
        }

        [HttpDelete("categories/{id}")]
        public IActionResult DeleteCategory(Guid id)
        {
            try
            {
                CategoriesService.Remove(id); 
                return NoContent();
            }
            catch (ComiesArgumentException ex)
            {
                return BadRequest(ex.Message);
            }
            catch (ComiesNotFoundException ex)
            {
                return NotFound(ex.Message);
            }
            catch (System.Exception)
            {
                throw new Exception("Ops! Um erro inesperado ocorreu.");
            }
            
        }

    }
}
