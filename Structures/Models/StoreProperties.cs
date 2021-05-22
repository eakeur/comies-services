using comies_services.Structures.Enumerators;
using System.Collections.Generic;
using FluentValidator;
using System;
namespace comies_services.Structures.Models
{
    public class StoreProperty : StoreOwnedEntity
    {
        public int Id { get; set; }
        public int ParentId { get; set; }
        public string Key { get; set; }
        public string Value { get; set; }
        public string AllowOverride { get; set; }
        public virtual StoreProperty Parent { get; set; }
        public virtual ICollection<StoreProperty> Children { get; set; }


    }
}