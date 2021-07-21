using Comies;
using System.Collections.Generic;
using System;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
namespace Comies
{
    public class Product : StoreOwnedEntity
    {
        [Required(ErrorMessage="Ops! Precisamos de um código para esse produto")]
        [MaxLength(6)]
        [MinLength(3)]
        public string Code { get; set; }

        [Required(ErrorMessage="Ops! Precisamos de um nome para esse produto")]
        [MaxLength(150)]
        [MinLength(3)]
        public string Name { get; set; }

        [Required(ErrorMessage="Ops! Precisamos de um nome de exibição bem legal para seus clientes verem")]
        [MaxLength(70)]
        [MinLength(3)]
        public string Display { get; set; }

        [MaxLength(500)]
        public string Description { get; set; }

        [Required(ErrorMessage="Ops! Precisamos da unidade em que esse produto será vendido")]
        public Unity SellUnity { get; set; }

        public double Minimum { get; set; }
        public Guid? CategoryId { get; set; }

        [MaxLength(200)]
        public string Tags { get; set; }
        public decimal Discount { get; set; }
        public decimal Price { get; set; }
        public decimal Value { get; set; }
        public virtual ProductCategory Category { get; set; }
        public virtual IList<OrderItem> Orders { get; set; }
        public virtual IList<Ingredient> Ingredients { get; set; }
        public virtual IList<Ingredient> Featuring { get; set; }
        public ProductType Type { get; set; }

    }
}