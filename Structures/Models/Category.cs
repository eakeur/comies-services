using System.Collections.Generic;
using FluentValidator;
namespace comies_services.Structures.Models
{
    public class ProductCategory : StoreOwnedEntity
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public int Description { get; set; }
        public int ParentCategoryId { get; set; }
        public virtual ProductCategory ParentCategory { get; set; }
        public virtual ICollection<ProductCategory> ChildrenCategories { get; set; }
        public virtual ICollection<Product> Products { get; set; }


    }
}