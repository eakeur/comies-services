using System.Collections.Generic;
using System.Threading.Tasks;
using Comies.Contracts;
using System.Linq;
using System;


namespace Comies.Customers {
    public class CustomersService : Service<Costumer, CustomerView, CustomerFilter>, ICustomersService
    {
        public CustomersService(ComiesContext context, IAuthenticatedOperator applicant): base(context, applicant) {}
        public override async Task<IEnumerable<CustomerView>> GetSome(CustomerFilter filter)
        {
            if (string.IsNullOrEmpty(filter.PhoneNumber)){

            } else {
                from c in Collection
                join p in Context.Phones on p. equals c.Id into stocks from stockref in stocks.DefaultIfEmpty()
            }
            return await (
                from p in Context.Costumers
                where
                    p.Active&&
                    (filter.Code != null ? p.Code.Contains(filter.Code) : true) &&
                    (filter.Name != null ? p.Name.Contains(filter.Code) : true) &&
                    (filter.ParentId != Guid.Empty ? filter.ParentId == p.ParentId : filter.ParentId == Guid.Empty)
                select new CategoryView {
                    Id = p.Id, Name = p.Name, Parent = p.ParentId, Code = p.Code
                }
            ).Skip(filter.Skip).Take(50).ToListAsync();
        }

        public override void Validate(Costumer product)
        {
            base.Validate(product);
            if (product.Name.Length < 1 && product.Name.Length > 200) 
                throw new ComiesArgumentException(message: "Ops! O nome do cliente deve ter de 1 a 200 caracteres");
        }
    }
}
