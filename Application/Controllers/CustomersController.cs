using Microsoft.AspNetCore.Mvc;
using Comies.Customers;
using Microsoft.AspNetCore.Authorization;
using System;
using System.Threading.Tasks;
using System.Collections.Generic;

namespace Comies.Controllers
{
    [ApiController]
    [Route(("api/v1/customers"))]
    [Authorize]
    public class CustomersController : BaseController<Customer, CustomerView, CustomerFilter, ICustomersService>
    {
        public CustomersController(ICustomersService service) : base(service) { }

        #region Address Endpoints

        [HttpGet("{customerId}/addresses")]
        public async Task<ActionResult<IEnumerable<Address>>> GetSomeAddresses(Guid customerId)
        {
            return await base.SendSome<Address>(() => Service.GetAddresses(customerId));
        }
        

        [HttpPost("{customerId}/addresses")]
        public async Task<ActionResult<Address>> SaveAddress(Guid customerId, Address structure)
        {
            return await base.SaveSent<Address>(() => Service.SaveAddress(structure, customerId), "GetAddress");
        }

        [HttpGet("{customerId}/addresses/{id}")]
        public async Task<ActionResult<Address>> GetAddress(Guid customerId, Guid id)
        {
            return await base.SendOne<Address>(() => Service.GetAddress(id, customerId));
        }

        [HttpDelete("{customerId}/addresses/{id}")]
        public async Task<IActionResult> RemoveAddress(Guid customerId, Guid id)
        {
            return await base.RemoveSent(() =>  Service.RemoveAddress(id, customerId));
        }

        [HttpPut("{customerId}/addresses/{id}")]
        public async Task<IActionResult> UpdateAddress(Guid customerId, Guid id, Address entity)
        {
            return await base.UpdateSent(() => Service.UpdateAddress(id, entity, customerId));
        }

        #endregion

        #region Phone Endpoints

        [HttpGet("{customerId}/phones")]
        public async Task<ActionResult<IEnumerable<Phone>>> GetSomePhones(Guid customerId)
        {
            return await base.SendSome<Phone>(() => Service.GetPhones(customerId));
        }

        [HttpPost("{customerId}/phones")]
        public async Task<ActionResult<Phone>> SavePhone(Guid customerId, Phone structure)
        {
            return await base.SaveSent<Phone>(() => Service.SavePhone(structure, customerId), "GetPhone");
        }

        [HttpGet("{customerId}/phones/{id}")]
        public async Task<ActionResult<Phone>> GetPhone(Guid customerId, Guid id)
        {
            return await base.SendOne<Phone>(() => Service.GetPhone(id, customerId));
        }

        [HttpDelete("{customerId}/phones/{id}")]
        public async Task<IActionResult> RemovePhone(Guid customerId, Guid id)
        {
            return await base.RemoveSent(() => Service.RemovePhone(id, customerId));
        }

        [HttpPut("{customerId}/phones/{id}")]
        public async Task<IActionResult> UpdatePhone(Guid customerId, Guid id, Phone entity)
        {
            return await base.UpdateSent(() => Service.UpdatePhone(id, entity, customerId));
        }

        #endregion

    }
}