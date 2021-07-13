using Comies.Contracts;
using System;

namespace Comies.Products
{
    public interface IStocksService : IService<Stock, ProductView, StockFilter> {
        void IncreaseStock(double value, Guid stockId);
        void DecreaseStock(double value, Guid stockId);
    }
}