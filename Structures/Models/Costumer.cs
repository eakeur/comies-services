using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System;

namespace Comies.Structures.Models
{
    public class Costumer : Entity
    {
        public int Id { get; set; }
        
        [Required(ErrorMessage="Ops! Você precisa informar um nome.")]
        public string Name { get; set; }
        public string Document { get; set; }
        public DateTime MemberSince { get; set; }
        public virtual IList<Address> Addresses { get; set; }
        public virtual IList<Phone> Phones { get; set; }
        public virtual IList<Order> Orders { get; set; }

    }
}