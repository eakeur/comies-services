using System.Threading.Tasks;
using System.Collections.Generic;
using Comies.Contracts;
using System;

namespace Comies.Products
{
    public interface IStocksService : IService<Stock, Stock, StockFilter> {
        Task IncreaseStock(double value, Guid stockId);
        Task DecreaseStock(double value, Guid stockId);
        Task<StockMovement> SaveStockMovement(StockMovement entity, Guid stockId);
        Task<StockMovement> UpdateStockMovement(Guid id, StockMovement entity, Guid stockId);
        Task<StockMovement> RemoveStockMovement(Guid id, Guid stockId);
        Task<StockMovement> GetStockMovement(Guid id, Guid stockId);
        Task<Stock> GetByProductId(Guid productId);
        Task<IEnumerable<StockMovement>> GetStockMovements(Guid stockId);
    }
}