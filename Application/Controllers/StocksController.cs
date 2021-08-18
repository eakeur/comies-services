using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using System.Threading.Tasks;
using Comies.Products;
using System;
namespace Comies.Controllers
{
    [ApiController]
    [Route(("api/v1/stocks"))]
    public class StocksController : BaseController<Stock, Stock, StockFilter, IStocksService>
    {
        public StocksController(IStocksService service) : base(service) {}

        #region Stock Movements Endpoints

        [HttpGet("{stockId}/stockMovements")]
        public async Task<ActionResult<IEnumerable<StockMovement>>> GetSomeStockMovements(Guid stockId)
        {
            return await base.SendSome<StockMovement>(() => Service.GetStockMovements(stockId));
        }

        [HttpPost("{stockId}/stockMovements")]
        public async Task<ActionResult<StockMovement>> SaveStockMovement(Guid stockId, StockMovement structure)
        {
            return await base.SaveSent<StockMovement>(() => Service.SaveStockMovement(structure, stockId), "GetStockMovement", (p) => new { id = p.Id, stockId = p.StockId});
        }

        [HttpGet("{stockId}/stockMovements/{id}")]
        public async Task<ActionResult<StockMovement>> GetStockMovement(Guid stockId, Guid id)
        {
            return await base.SendOne<StockMovement>(() => Service.GetStockMovement(id, stockId));
        }

        [HttpDelete("{stockId}/stockMovements/{id}")]
        public async Task<IActionResult> RemoveStockMovement(Guid stockId, Guid id)
        {
            return await base.RemoveSent(() => Service.RemoveStockMovement(id, stockId));
        }

        [HttpPut("{stockId}/stockMovements/{id}")]
        public async Task<IActionResult> UpdateStockMovement(Guid stockId, Guid id, StockMovement entity)
        {
            return await base.UpdateSent(() => Service.UpdateStockMovement(id, entity, stockId));
        }

        #endregion
    }
}