using Comies.Contracts;
using System;
using System.Threading.Tasks;
using System.Collections.Generic;
namespace Comies.Products
{
    public interface IProductsService : IService<Product, ProductView, ProductFilter> {
        Task<Ingredient> AddIngredient(Ingredient ingredient, Guid productId);
        Task<Ingredient> UpdateIngredient(Guid id, Ingredient ingredient, Guid productId);
        Task<Ingredient> RemoveIngredient(Guid id, Guid productId);
        Task<Ingredient> GetIngredient(Guid id, Guid productId);
        Task<IEnumerable<Ingredient>> GetIngredients(Guid productId);



    }
}