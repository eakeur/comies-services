using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Comies;
using Comies.Contracts;
namespace Comies.Services
{
    public class ProductService
    {
        private readonly ComiesContext Context;

        public ProductService(ComiesContext context) { this.Context = context; }

        public bool ExistsId(Guid key)
        {
            
            throw new NotImplementedException();
        }

        public bool ExistsCode(string key)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<Product> GetAll()
        {
            throw new NotImplementedException();
        }

        public Product GetOne(Guid Id)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<Product> GetSome(IFilter filter)
        {
            throw new NotImplementedException();
        }

        public Product Remove(Guid Id)
        {
            throw new NotImplementedException();
        }

        public Product Save(Product entity)
        {
            var i = Context.Addresses.AsEnumerable();
            foreach (var item in i)
            {
                Console.Write(item);
            }
            throw new NotImplementedException();
        }

        public Product Update(Guid Id, Product entity)
        {
            throw new NotImplementedException();
        }
    }
}
