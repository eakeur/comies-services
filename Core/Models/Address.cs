using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

using System;

namespace Comies
{
    public class Address : Entity
    {
        

        [Required(ErrorMessage="Ops! Precisamos do CEP desse endereço.")]
        [MaxLength(8)]
        public string CEP { get; set; }
        
        [Required(ErrorMessage="Ops! Precisamos do número desse endereço.")]
        [MaxLength(12)]
        public string Number { get; set; }

        [MaxLength(60)]
        public string District { get; set; }

        [MaxLength(60)]
        public string Complement { get; set; }

        [MaxLength(90)]
        public string Reference { get; set; }

        [MaxLength(200)]
        public string Street { get; set; }

        [MaxLength(100)]
        public string City { get; set; }

        [MaxLength(50)]
        public string State { get; set; }

        [MaxLength(50)]
        public string Country { get; set; }
        public Guid? CostumerId { get; set; }
        public virtual Costumer Costumer { get; set; }
    }

}