using System.Collections.Generic;
using Comies.Contracts;
using System.Linq;
using System;
using Comies;


namespace Comies.Products {
    public class CategoriesService : ICategoriesService
    {
        ComiesContext Context;
        IAuthenticatedOperator Applicant;
        public CategoriesService(ComiesContext context, IAuthenticatedOperator applicant){
            Context = context; Applicant = applicant;
        }

        public IEnumerable<CategoryView> GetAll()
        {
            throw new NotImplementedException();
        }

        public ProductCategory GetOne(Guid id)
        {
            return Context.ProductsCategories.FirstOrDefault(x => x.Id == id);
        }

        public IEnumerable<CategoryView> GetSome(CategoryFilter filter)
        {
            return (
                from p in Context.ProductsCategories
                where
                    p.Active && p.StoreId == Applicant.StoreId &&
                    (filter.Code != null ? p.Code.Contains(filter.Code) : true) &&
                    (filter.Name != null ? p.Name.Contains(filter.Code) : true) &&
                    (filter.ParentId != Guid.Empty ? filter.ParentId == p.ParentId : filter.ParentId == Guid.Empty)
                select new CategoryView {
                    Id = p.Id, Name = p.Name, Parent = p.ParentId, Code = p.Code
                }
            ).Skip(filter.Skip).Take(50).ToList();
        }

        public ProductCategory Remove(Guid id)
        {
            var prod = Context.ProductsCategories.FirstOrDefault(x => x.Id == id);
            if (prod != null){
                prod.Active = false;
                Context.ProductsCategories.Update(prod);
                Context.SaveChanges();
            } else throw new ComiesNotFoundException("Ops! Não foi possível encontrar essa categoria");
            return prod;
        }

        public ProductCategory Save(ProductCategory category)
        {
            Validate(category);
            category.StoreId = Applicant.StoreId;
            Context.ProductsCategories.Add(category);
            Context.SaveChanges();
            return category;
        }

        public ProductCategory Update(Guid id, ProductCategory category)
        {
            Validate(category);
            category.Id = id;
            Context.ProductsCategories.Update(category);
            Context.SaveChanges();
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