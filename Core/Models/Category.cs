using System.Collections.Generic;
using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Comies
{
    public class ProductCategory : StoreOwnedEntity
    {   
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public Guid Id { get; set; }

        [Required(ErrorMessage="Ops! Precisamos do código dessa categoria.")]
        [MaxLength(6, ErrorMessage="Ops! É preciso que o código tenha 6 ou menos caracteres")]
        [MinLength(3, ErrorMessage="Ops! É preciso que o código tenha 3 ou mais caracteres")]
        public string Code { get; set; }

        [Required(ErrorMessage="Ops! Precisamos do nome dessa categoria.")]
        [MaxLength(100)]
        [MinLength(2)]
        public string Name { get; set; }

        [MaxLength(200)]
        public Guid Description { get; set; }
        public Guid ParentId { get; set; }
        public virtual ProductCategory Parent { get; set; }
        public virtual IList<ProductCategory> Children { get; set; }
        public virtual IList<Product> Products { get; set; }


    }
}