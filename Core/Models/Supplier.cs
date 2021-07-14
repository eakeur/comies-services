using Comies;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System;
using System.ComponentModel.DataAnnotations;
namespace Comies
{
    public class Supplier : StoreOwnedEntity
    {
        
        [MaxLength(200)]
        public string Name { get; set; }
        [MaxLength(200)]
        public string CompanyName { get; set; }
        [MaxLength(200)]
        public string Document { get; set; }
        [MaxLength(200)]
        public string ContactName { get; set; }
        public DateTime MemberSince { get; set; } 
        public Guid AddressId { get; set; }
        public Guid PhoneId { get; set; }
        public virtual Phone Phone { get; set; }
        public virtual Address Address { get; set; }
        public virtual IList<Stock> Stocks { get; set; }

    }
}