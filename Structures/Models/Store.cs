using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System;
namespace Comies.Structures.Models
{
    public class Store : StoreOwnedEntity
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string CompanyNickname { get; set; }
        public string CompanyName { get; set; }
        public string Document { get; set; }
        public string ContactName { get; set; }
        public virtual DateTime MemberSince { get; set; }  
        public virtual IList<Store> Stores { get; set; }
        public virtual IList<Product> Products { get; set; }
        public virtual IList<ProductCategory> ProductCategories { get; set; }
        public virtual IList<Operator> Operators { get; set; }
        public virtual IList<Order> Orders { get; set; }
        public virtual IList<Profile> Profiles { get; set; }
        public virtual IList<Stock> Stocks { get; set; }
        public virtual IList<StockMovement> StockMovements { get; set; }
        public virtual IList<StoreProperty> StoreProperties { get; set; }

    }
}