using System;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
namespace Comies
{
    public class Phone : Entity
    {
        

        [MaxLength(2)]
        public string DDD { get; set; }

        [MaxLength(9)]
        public string Number { get; set; }
        public Guid? CostumerId { get; set; }
        public virtual Costumer Costumer { get; set; }
    }
}