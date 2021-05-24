using System.ComponentModel.DataAnnotations;

namespace Comies.Structures.Models
{
    public class Address : Entity
    {
        public int Id { get; set; }

        [Required(ErrorMessage="Ops! Precisamos do CEP desse endereço.")]
        public string CEP { get; set; }
        
        [Required(ErrorMessage="Ops! Precisamos do número desse endereço.")]
        public string Number { get; set; }
        public string District { get; set; }
        public string Complement { get; set; }
        public string Reference { get; set; }
        public string Street { get; set; }
        public string City { get; set; }
        public string State { get; set; }
        public string Country { get; set; }
        public int CostumerId { get; set; }
        public Costumer Costumer { get; set; }
    }

}