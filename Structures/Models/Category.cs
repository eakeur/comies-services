using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace Comies.Structures.Models
{
    public class ProductCategory : StoreOwnedEntity
    {   
        public int Id { get; set; }

        [Key]
        [Required(ErrorMessage="Ops! Precisamos do código dessa categoria.")]
        [MaxLength(6, ErrorMessage="Ops! É preciso que o código tenha 6 ou menos caracteres")]
        [MinLength(3, ErrorMessage="Ops! É preciso que o código tenha 3 ou mais caracteres")]
        public string Code { get; set; }

        [Required(ErrorMessage="Ops! Precisamos do nome dessa categoria.")]
        public string Name { get; set; }
        public int Description { get; set; }
        public int ParentCategoryId { get; set; }
        public ProductCategory ParentCategory { get; set; }
        public virtual IList<ProductCategory> ChildrenCategories { get; set; }
        public virtual IList<Product> Products { get; set; }


    }
}