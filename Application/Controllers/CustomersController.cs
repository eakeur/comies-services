using Microsoft.AspNetCore.Mvc;
using Comies.Customers;
namespace Comies.Controllers
{
    [ApiController]
    [Route(("api/v1/customers"))]
    public class CustomersController : BaseController<Costumer, CustomerView, CustomerFilter>
    {
        public CustomersController(ICustomersService service) : base(service) {}
    }
}