using comies_services.Structures.Enumerators;
using System.Collections.Generic;
using FluentValidator;
using System;
namespace comies_services.Structures.Models
{
    public class Store : StoreOwnedEntity
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string CompanyName { get; set; }
        public string Document { get; set; }
        public string ContactName { get; set; }
        public DateTime MemberSince { get; set; }  
        public virtual ICollection<Store> Stores { get; set; }
        public virtual ICollection<Product> Products { get; set; }
        public virtual ICollection<Address> Addresses { get; set; }
        public virtual ICollection<ProductCategory> ProductCategories { get; set; }
        public virtual ICollection<Costumer> Costumers { get; set; }
        public virtual ICollection<Operator> Operators { get; set; }
        public virtual ICollection<Order> Orders { get; set; }
        public virtual ICollection<Phone> Phones { get; set; }
        public virtual ICollection<Profile> Profiles { get; set; }
        public virtual ICollection<Stock> Stocks { get; set; }
        public virtual ICollection<StockMovement> StockMovements { get; set; }
        public virtual ICollection<StoreProperty> StoreProperties { get; set; }

    }
}