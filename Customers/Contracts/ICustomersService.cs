using Comies.Contracts;
using System;
using System.Threading.Tasks;
using System.Collections.Generic;
namespace Comies.Customers
{
    public interface ICustomersService : IService<Customer, CustomerView, CustomerFilter>
    {
        public Task<Address> SaveAddress(Address address);

        public Task<Address> UpdateAddress(Guid id, Address address);

        public Task<Address> RemoveAddress(Guid id, Guid customerId);

        public Task<Address> GetAddress(Guid id, Guid customerId);

        public Task<IEnumerable<Address>> GetAddresses(Guid customerId);
    }
}