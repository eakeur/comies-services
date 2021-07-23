using Comies.Contracts;
using System;
using System.Threading.Tasks;
using System.Collections.Generic;
namespace Comies.Customers
{
    public interface ICustomersService : IService<Customer, CustomerView, CustomerFilter>
    {
        public Task<Address> SaveAddress(Address address, Guid customerId);

        public Task<Address> UpdateAddress(Guid id, Address address, Guid customerId);

        public Task<Address> RemoveAddress(Guid id, Guid customerId);

        public Task<Address> GetAddress(Guid id, Guid customerId);

        public Task<IEnumerable<Address>> GetAddresses(Guid customerId);

        public Task<Phone> SavePhone(Phone phone, Guid customerId);

        public Task<Phone> UpdatePhone(Guid id, Phone phone, Guid customerId);

        public Task<Phone> RemovePhone(Guid id, Guid customerId);

        public Task<Phone> GetPhone(Guid id,  Guid customerId);

        public Task<IEnumerable<Phone>> GetPhones(Guid customerId);


    }
}