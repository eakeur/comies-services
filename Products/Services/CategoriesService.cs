using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;
using System.Threading.Tasks;
using Comies.Contracts;
using System.Linq;
using System;


namespace Comies.Products {
    public class CategoriesService : ICategoriesService
    {
        ComiesContext Context;
        IAuthenticatedOperator Applicant;
        public CategoriesService(ComiesContext context, IAuthenticatedOperator applicant){
            Context = context; Applicant = applicant;
        }

        public Task<IEnumerable<CategoryView>> GetAll()
        {
            throw new NotImplementedException();
        }

        public async Task<ProductCategory> GetOne(Guid id)
        {
            return await Context.ProductsCategories.FirstOrDefaultAsync(x => x.Id == id);
        }

        public async Task<IEnumerable<CategoryView>> GetSome(CategoryFilter filter)
        {
            return await (
                from p in Context.ProductsCategories
                where
                    p.Active && p.StoreId == Applicant.StoreId &&
                    (filter.Code != null ? p.Code.Contains(filter.Code) : true) &&
                    (filter.Name != null ? p.Name.Contains(filter.Code) : true) &&
                    (filter.ParentId != Guid.Empty ? filter.ParentId == p.ParentId : filter.ParentId == Guid.Empty)
                select new CategoryView {
                    Id = p.Id, Name = p.Name, Parent = p.ParentId, Code = p.Code
                }
            ).Skip(filter.Skip).Take(50).ToListAsync();
        }

        public async Task<ProductCategory> Remove(Guid id)
        {
            var prod = await Context.ProductsCategories.FirstOrDefaultAsync(x => x.Id == id);
            if (prod != null){
                prod.Active = false;
                Context.ProductsCategories.Update(prod);
                await Context.SaveChangesAsync();
            } else throw new ComiesNotFoundException("Ops! Não foi possível encontrar essa categoria");
            return prod;
        }

        public async Task<ProductCategory> Save(ProductCategory category)
        {
            Validate(category);
            category.StoreId = Applicant.StoreId;
            Context.ProductsCategories.Add(category);
            await Context.SaveChangesAsync();
            return category;
        }

        public async Task<ProductCategory> Update(Guid id, ProductCategory category)
        {
            Validate(category);
            category.Id = id;
            Context.ProductsCategories.Update(category);
            await Context.SaveChangesAsync();
            return category;
        }

        public void Validate(ProductCategory category){
            if (category.Code.Length < 3 && category.Code.Length > 6)
                throw new ComiesArgumentException(message: "Ops! O código da categoria precisa ter de 3 a 6 caracteres");
            if (category.Name.Length < 3 && category.Name.Length > 100) 
                throw new ComiesArgumentException(message: "Ops! O nome da categoria deve ter de 3 a 100 caracteres");
        }
    }
}