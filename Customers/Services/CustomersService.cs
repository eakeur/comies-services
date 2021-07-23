using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;
using System.Threading.Tasks;
using Comies.Contracts;
using System.Linq;
using System;


namespace Comies.Customers {
    public class CustomersService : ServiceBase<Costumer, CustomerView, CustomerFilter>, ICustomersService
    {
        public CustomersService(ComiesContext context, IAuthenticatedOperator applicant): base(context, applicant) {}

        public override async Task<IEnumerable<CustomerView>> GetSome(CustomerFilter filter)
        {
            
            return await (from c in Collection
            join p in Context.Phones on c.Id equals p.CostumerId into phones from phoneref in phones.DefaultIfEmpty()
            where 
                (string.IsNullOrEmpty(filter.PhoneNumber) || phoneref.Number.StartsWith(filter.PhoneNumber) || phoneref.Number.EndsWith(filter.PhoneNumber)) &&
                (filter.Name == null || c.Name.Contains(filter.Name))
            select new CustomerView
            {
                Id = c.Id, Name = c.Name, Phone = phoneref //$"+55 ({phoneref.DDD}) {phoneref.Number}"
            }).Skip(filter.Skip).Take(50).ToListAsync();
        }

        public override void Validate(Costumer product)
        {
            base.Validate(product);
            if (product.Name.Length < 1 && product.Name.Length > 200) 
                throw new ComiesArgumentException(message: "Ops! O nome do cliente deve ter de 1 a 200 caracteres");
        }
    }
}
