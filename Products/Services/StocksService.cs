using System.Collections.Generic;
using Comies.Contracts;
using System.Linq;
using System;
using Comies;


namespace Comies.Products {
    public class StocksService : IStocksService
    {
        ComiesContext Context;
        IAuthenticatedOperator Applicant;

        public StocksService(ComiesContext context, IAuthenticatedOperator applicant){
            Context = context; Applicant = applicant;
        }

        public void DecreaseStock(double value, Guid stockId)
        {
            var stock = GetOne(stockId);
            stock.Actual -= value;
            Update(stockId, stock);

        }

        public IEnumerable<ProductView> GetAll()
        {
            throw new NotImplementedException();
        }

        public Stock GetOne(Guid id)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<ProductView> GetSome(StockFilter filter)
        {
            throw new NotImplementedException();
        }

        public void IncreaseStock(double value, Guid stockId)
        {
            var stock = GetOne(stockId);
            stock.Actual += value;
            Update(stockId, stock);
        }

        public Stock Remove(Guid id)
        {
            throw new NotImplementedException();
        }

        public Stock Save(Stock entity)
        {
            throw new NotImplementedException();
        }

        public Stock Update(Guid id, Stock entity)
        {
            throw new NotImplementedException();
        }

        public void Validate(Stock entity)
        {
            throw new NotImplementedException(); 
        }
    }
}