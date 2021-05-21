using comies_services.Structures.Enumerators;
using System.Collections.Generic;
using System;
namespace comies_services.Structures.Models
{
    public class Costumer : PartnerEntity
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Document { get; set; }
        public DateTime MemberSince { get; set; }
        public virtual ICollection<Address> Addresses { get; set; }
        public virtual ICollection<Phone> Phones { get; set; }
        //public virtual ICollection<Order> Orders { get; set; }

    }
}