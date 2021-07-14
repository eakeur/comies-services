using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;
using System.Threading.Tasks;
using Comies.Contracts;
using System.Linq;
using System;


namespace Comies.Products {
    public class ProductsService : Service<Product, ProductView, ProductFilter>, IProductsService
    {
        // ComiesContext Context;
        // IAuthenticatedOperator Applicant;

        public ProductsService(ComiesContext context, IAuthenticatedOperator applicant): base(context, applicant)
        {
            
        }

        // public async Task<Product> GetOne(Guid id)
        // {
        //     return await Context.Products.FirstOrDefaultAsync(x => x.Id == id && x.Active);
        // }

        public override async Task<IEnumerable<ProductView>> GetSome(ProductFilter filter)
        {

            return await (from p in Context.Products
                    join s in Context.Stocks on p.StockId equals s.Id into stocks from stockref in stocks.DefaultIfEmpty()
                    join c in Context.ProductsCategories on p.CategoryId equals c.Id into cats from cat in cats.DefaultIfEmpty()
                    where
                        p.Active && p.StoreId == Applicant.StoreId &&
                        (filter.Code != null ? p.Code.Contains(filter.Code) : true) &&
                        (filter.Name != null ? p.Name.Contains(filter.Code) : true) &&
                        (filter.Tag != null ? p.Tags.Contains(filter.Tag) : true) &&
                        (filter.CategoryId != Guid.Empty ? p.CategoryId == filter.CategoryId : true)
                    select new ProductView
                    {
                        Id = p.Id,
                        Name = p.Name,
                        Code = p.Code,
                        Value = p.Value,
                        StockLevel = stockref == null ? 0.00 : Math.Round(stockref.Actual * 100 / stockref.Maximum),
                        CategotyId = p.CategoryId.GetValueOrDefault(),
                        CategoryName = cat.Name
                    }).ToListAsync();
        }

        // public async Task<Product> Remove(Guid id)
        // {
        //     var prod = await Context.Products.FirstOrDefaultAsync(x => x.Id == id);
        //     if (prod != null){
        //         prod.Active = false;
        //         Context.Products.Update(prod);
        //         await Context.SaveChangesAsync();
        //     }
        //     return prod;
        // }


        public override async Task<Product> Save(Product product)
        {
            Validate(product);
            product.StoreId = Applicant.StoreId;
            product.Active = true;
            return await base.Save(product);
        }

        public override async Task<Product> Update(Guid id, Product product)
        {
            Validate(product); product.Id = id;
            return await base.Update(id, product);
        }

        // public Ingredient SaveIngredient(Guid productId, Ingredient ingredient)
        // {
        //     ingredient.ProductId = productId;
        //     ingredient.Active = true;
        //     ingredient.StoreId = Applicant.Id;
        //     Context.Ingredients.Add(ingredient);
        //     await Context.SaveChangesAsync();
        //     return ingredient;
        // }
        // public Ingredient RemoveIngredient(Guid id)
        // {
        //     var prod = await Context.Ingredients.FirstOrDefaultAsync(x => x.Id == id);
        //     if (prod != null){
        //         prod.Active = false;
        //         Context.Ingredients.Remove(prod);
        //         await Context.SaveChangesAsync();
        //     }
        //     return prod;
        // }

        // public Ingredient UpdateIngredient(Guid productId, Ingredient ingredient)
        // {
        //     throw new NotImplementedException();
        // }

        // public IEnumerable<Ingredient> GetAllIngredients(Guid productId){
        //     return Context.Ingredients.Where(x => x.ProductId == productId);
        // }

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
    }
}