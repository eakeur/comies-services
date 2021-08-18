using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;
using Comies.Contracts;
using System.Linq;
using System;
using Comies;
using System.Threading.Tasks;

namespace Comies.Products {
    public class StocksService : ServiceBase<Stock, Stock, StockFilter>, IStocksService
    {

        public StocksService(ComiesContext context, IAuthenticatedOperator applicant): base(context, applicant){}

        public async Task DecreaseStock(double value, Guid stockId)
        {
            var stock = await GetOne(stockId);
            stock.Actual -= value;
            await Update(stockId, stock);
        }

        public async Task IncreaseStock(double value, Guid stockId)
        {
            var stock = await GetOne(stockId);
            stock.Actual += value;
            await Update(stockId, stock);
        }

        public override async Task<IEnumerable<Stock>> GetSome(StockFilter filter)
        {
            return await (
                from s in Context.Stocks
                where s.Active && s.StoreId == Applicant.StoreId &&
                    (filter.ProductId != Guid.Empty ? s.ProductId == filter.ProductId : true) &&
                    (filter.Date != null ? s.Date == filter.Date : true)
                select s
            ).OrderBy(x => x.Minimum).ToListAsync();
        }

        public async Task<Stock> GetByProductId(Guid productId)
        {
            return await Context.Stocks.FirstAsync(x => x.Active && x.StoreId == Applicant.StoreId && x.ProductId == productId);
        }
        public override void Validate(Stock entity)
        {
            base.Validate(entity);
        }

        #region Movements
        public async Task<StockMovement> SaveStockMovement(StockMovement entity, Guid stockId)
        {
            ValidateStockMovement(entity);
            entity.Active = true;
            entity.StockId = stockId;
            Context.StocksMovements.Add(entity);
            await Context.SaveChangesAsync();
            return entity;
        }

        public async Task<StockMovement> UpdateStockMovement(Guid id, StockMovement entity, Guid stockId)
        {
            ValidateStockMovement(entity); entity.Id = id; entity.StockId = stockId;
            Context.StocksMovements.Update(entity);
            await Context.SaveChangesAsync();
            return entity;
        }

        public async Task<StockMovement> RemoveStockMovement(Guid id, Guid stockId)
        {
            var entity = await GetStockMovement(id, stockId);
            if (entity != null)
            {
                Context.StocksMovements.Remove(entity);
                await Context.SaveChangesAsync();
            }
            return entity;
        }

        public async Task<StockMovement> GetStockMovement(Guid id, Guid stockId)
        {
            return await Context.StocksMovements.FirstOrDefaultAsync(x => x.Active && x.Id == id && x.StockId == stockId);
        }

        public async Task<IEnumerable<StockMovement>> GetStockMovements(Guid stockId)
        {
            return await Context.StocksMovements.Where(x => x.StockId == stockId && x.Active).ToListAsync();
        }

        public void ValidateStockMovement(StockMovement entity)
        {
            if (entity == null) throw new ComiesArgumentException("Ops! O telefone é inválido.");
        }
        #endregion
    }
}