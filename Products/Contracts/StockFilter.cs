using Comies.Contracts;
using System;

namespace Comies.Products
{
    public class StockFilter : IFilter 
    {

        public Guid ProductId { get; set; }
        public DateTime? Date { get; set; }
        public int Skip { get; set; }


        
    }
}