using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;
using System.Threading.Tasks;
using Comies.Contracts;
using System.Linq;
using System;


namespace Comies.Products {
    public class ProductsService : ServiceBase<Product, ProductView, ProductFilter>, IProductsService
    {
        public ProductsService(ComiesContext context, IAuthenticatedOperator applicant): base(context, applicant){}

        public override async Task<IEnumerable<ProductView>> GetSome(ProductFilter filter)
        {

            return await (from p in Context.Products
                    join s in Context.Stocks on p.Id equals s.ProductId into stocks from stockref in stocks.DefaultIfEmpty()
                    join c in Context.ProductsCategories on p.CategoryId equals c.Id into cats from cat in cats.DefaultIfEmpty()
                    where
                        p.Active && p.StoreId == Applicant.StoreId &&
                        (filter.Code != null ? p.Code.Contains(filter.Code) : true) &&
                        (filter.Name != null ? p.Name.Contains(filter.Name) : true) &&
                        (filter.Tag != null ? p.Tags.Contains(filter.Tag) : true) &&
                        (filter.CategoryId != Guid.Empty ? p.CategoryId == filter.CategoryId : true)
                    select new ProductView
                    {
                        Id = p.Id,
                        Name = p.Name,
                        Code = p.Code,
                        Value = p.Value,
                        StockLevel = stockref == null ? 0.00 : Math.Round(stockref.Actual * 100 / stockref.Maximum),
                        CategoryId = p.CategoryId.GetValueOrDefault(),
                        CategoryName = cat.Name
                    }).ToListAsync();
        }

        

        public override void Validate(Product product)
        {
            base.Validate(product);
            if (product.Price <= 0) 
                throw new ComiesArgumentException(message: "Ops! O produto precisa que o preço seja maior que 0");
            if (product.Value <= 0)
                throw new ComiesArgumentException(message: "Ops! O valor do produto deve ser maior que zero");
            if (product.Code.Length < 3 && product.Code.Length > 6)
                throw new ComiesArgumentException(message: "Ops! O código do produto precisa ter de 3 a 6 caracteres");
            if (product.Name.Length < 3 && product.Name.Length > 150) 
                throw new ComiesArgumentException(message: "Ops! O nome do produto deve ter de 3 a 150 caracteres");
            if (product.Display.Length < 3 && product.Display.Length > 70) 
                throw new ComiesArgumentException(message: "Ops! O nome de exibição do produto deve ter de 3 a 70 caracteres");
        }

        #region Ingredients

        public async Task<Ingredient> AddIngredient(Ingredient entity, Guid productId)
        {
            ValidateIngredient(entity);
            entity.Active = true;
            entity.ProductId = productId;
            Context.Ingredients.Add(entity);
            await Context.SaveChangesAsync();
            entity.Component = await GetOne(entity.IngredientId);
            return entity;
        }

        public async Task<Ingredient> UpdateIngredient(Guid id, Ingredient entity, Guid productId)
        {
            ValidateIngredient(entity); entity.Id = id; entity.ProductId = productId;
            Context.Ingredients.Update(entity);
            await Context.SaveChangesAsync();
            entity.Component = await GetOne(entity.IngredientId);
            return entity;
        }

        public async Task<Ingredient> RemoveIngredient(Guid id, Guid productId)
        {
            var entity = await GetIngredient(id, productId);
            if (entity != null)
            {
                entity.Active = false;
                Context.Ingredients.Update(entity);
                await Context.SaveChangesAsync();
            }
            return entity;
        }

        public async Task<Ingredient> GetIngredient(Guid id, Guid productId)
        {
            var entity =  await Context.Ingredients.FirstOrDefaultAsync(x => x.Active && x.Id == id && x.ProductId == productId);
            entity.Component = await GetOne(entity.IngredientId);
            return entity;
        }

        public async Task<IEnumerable<Ingredient>> GetIngredients(Guid productId)
        {
            var entities = await Context.Ingredients.Where(x => x.ProductId == productId).ToListAsync();
            foreach (var entity in entities)
            {
                entity.Component = await GetOne(entity.IngredientId);
            }
            return entities;
        }

        private void ValidateIngredient(Ingredient entity)
        {
            if (entity == null) throw new ComiesArgumentException("Ops! O ingrediente passado é inválido");
        }

        #endregion
    }


     
}