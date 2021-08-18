using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;
using System.Threading.Tasks;
using Comies.Contracts;
using System.Linq;
using System;
using System.Diagnostics.CodeAnalysis;

namespace Comies.Customers {
    public class CustomersService : ServiceBase<Customer, CustomerView, CustomerFilter>, ICustomersService
    {
        public CustomersService(ComiesContext context, IAuthenticatedOperator applicant): base(context, applicant) {}

        public override async Task<IEnumerable<CustomerView>> GetSome(CustomerFilter filter)
        {
            
            var customerPhones =  await (from c in Collection
            join p in Context.Phones on c.Id equals p.CustomerId into phones from phoneref in phones.DefaultIfEmpty()
            where 
                (string.IsNullOrEmpty(filter.PhoneNumber) || phoneref.Number.StartsWith(filter.PhoneNumber) || phoneref.Number.EndsWith(filter.PhoneNumber)) &&
                (filter.Name == null || c.Name.Contains(filter.Name))
            select new CustomerView
            {
                Id = c.Id, Name = c.Name, Phone = phoneref //$"+55 ({phoneref.DDD}) {phoneref.Number}"
            }).Skip(filter.Skip).Take(50).ToListAsync();

            return customerPhones.Distinct(new CustomerViewEqualityComparer());
        }

        public override void Validate(Customer product)
        {
            base.Validate(product);
            if (product.Name.Length < 1 && product.Name.Length > 200)
                throw new ComiesArgumentException(message: "Ops! O nome do cliente deve ter de 1 a 200 caracteres");
        }

        #region Addresses

        public async Task<Address> SaveAddress(Address entity, Guid customerId)
        {
            ValidateAddress(entity);
            entity.Active = true;
            entity.CustomerId = customerId;
            Context.Addresses.Add(entity);
            await Context.SaveChangesAsync();
            return entity;
        }

        public async Task<Address> UpdateAddress(Guid id, Address entity, Guid customerId)
        {
            ValidateAddress(entity); entity.Id = id; entity.CustomerId = customerId;
            Context.Addresses.Update(entity);
            await Context.SaveChangesAsync();
            return entity;
        }

        public async Task<Address> RemoveAddress(Guid id, Guid customerId)
        {
            var entity = await GetAddress(id, customerId);
            if (entity != null)
            {
                Context.Addresses.Remove(entity);
                await Context.SaveChangesAsync();
            }
            return entity;
        }

        public async Task<Address> GetAddress(Guid id, Guid customerId)
        {
            return await Context.Addresses.FirstOrDefaultAsync(x => x.Active && x.Id == id && x.CustomerId == customerId);
        }

        public async Task<IEnumerable<Address>> GetAddresses(Guid customerId)
        {
            return await Context.Addresses.Where(x => x.CustomerId == customerId).ToListAsync();
        }

        private void ValidateAddress(Address address)
        {
            if (address == null) throw new ComiesArgumentException("Ops! O endere�o passado � inv�lido");
        }

        #endregion

        #region Phones

        public async Task<Phone> SavePhone(Phone entity, Guid customerId)
        {
            ValidatePhone(entity);
            entity.Active = true;
            entity.CustomerId = customerId;
            Context.Phones.Add(entity);
            await Context.SaveChangesAsync();
            return entity;
        }

        public async Task<Phone> UpdatePhone(Guid id, Phone entity, Guid customerId)
        {
            ValidatePhone(entity); entity.Id = id; entity.CustomerId = customerId;
            Context.Phones.Update(entity);
            await Context.SaveChangesAsync();
            return entity;
        }

        public async Task<Phone> RemovePhone(Guid id, Guid customerId)
        {
            var entity = await GetPhone(id, customerId);
            if (entity != null)
            {
                Context.Phones.Remove(entity);
                await Context.SaveChangesAsync();
            }
            return entity;
        }

        public async Task<Phone> GetPhone(Guid id, Guid customerId)
        {
            return await Context.Phones.FirstOrDefaultAsync(x => x.Active && x.Id == id && x.CustomerId == customerId);
        }

        public async Task<IEnumerable<Phone>> GetPhones(Guid customerId)
        {
            return await Context.Phones.Where(x => x.CustomerId == customerId && x.Active).ToListAsync();
        }

        public void ValidatePhone(Phone entity)
        {
            if (entity == null) throw new ComiesArgumentException("Ops! O telefone � inv�lido.");
        }
        
        #endregion
    }
}
