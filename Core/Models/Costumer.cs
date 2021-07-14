using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System;

namespace Comies
{
    public class Costumer : Entity
    {
        
        
        [Required(ErrorMessage="Ops! Você precisa informar um nome.")]
        [MaxLength(200)]
        public string Name { get; set; }

        [MaxLength(20)]
        [MinLength(3)]
        public string Document { get; set; }
        public DateTime MemberSince { get; set; }
        public virtual IList<Address> Addresses { get; set; }
        public virtual IList<Phone> Phones { get; set; }
        public virtual IList<Order> Orders { get; set; }

    }
}