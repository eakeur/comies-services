using Comies.Structures.Enumerators;
using System.Collections.Generic;
using System;
namespace Comies.Structures.Models
{
    public class Supplier : StoreOwnedEntity
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string CompanyName { get; set; }
        public string Document { get; set; }
        public string ContactName { get; set; }
        public DateTime MemberSince { get; set; } 
        public int AddressId { get; set; }
        public int PhoneId { get; set; }
        public virtual Phone Phone { get; set; }
        public virtual Address Address { get; set; }
        public virtual IList<Stock> Stocks { get; set; }

    }
}