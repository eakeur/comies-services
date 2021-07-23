using Microsoft.AspNetCore.Mvc;
using Comies.Products;
namespace Comies.Controllers
{
    [ApiController]
    [Route(("api/v1/stocks"))]
    public class StocksController : BaseController<Stock, ProductView, StockFilter, IStocksService>
    {
        public StocksController(IStocksService service) : base(service) {}
    }
}