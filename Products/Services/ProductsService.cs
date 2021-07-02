using System.Collections.Generic;
using Comies.Contracts;
using System.Linq;
using System;
using Comies;


namespace Comies.Products {
    public class ProductsService : IProductsService
    {
        ComiesContext Context;
        IAuthenticatedOperator Applicant;

        public ProductsService(ComiesContext context, IAuthenticatedOperator applicant){
            Context = context; Applicant = applicant;
        }

        public IEnumerable<ProductView> GetAll()
        {
            throw new NotImplementedException();
        }

        public Product GetOne(Guid id)
        {
            return Context.Products.FirstOrDefault(x => x.Id == id);
        }

        public IEnumerable<ProductView> GetSome(ProductFilter filter)
        {

            return (from p in Context.Products
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
                    }).ToList();
        }

        public Product Remove(Guid id)
        {
            var prod = Context.Products.FirstOrDefault(x => x.Id == id);
            if (prod != null){
                prod.Active = false;
                Context.Products.Update(prod);
                Context.SaveChanges();
            }
            return prod;
        }

        public Product Save(Product product)
        {
            Validate(product);
            product.StoreId = Applicant.StoreId;
            Context.Products.Add(product);
            Context.SaveChanges();
            return product;
        }

        public Product Update(Guid id, Product product)
        {
            Validate(product);
            product.Id = id;
            Context.Products.Update(product);
            Context.SaveChanges();
            return product;
        }

        public void Validate(Product product){
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