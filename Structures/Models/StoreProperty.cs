using Comies.Structures.Enumerators;
using System.Collections.Generic;
using System;
namespace Comies.Structures.Models
{
    public class StoreProperty : StoreOwnedEntity
    {
        public int Id { get; set; }
        public int ParentId { get; set; }
        public string Key { get; set; }
        public string Value { get; set; }
        public string AllowOverride { get; set; }
        public virtual StoreProperty Parent { get; set; }
        public virtual IList<StoreProperty> Children { get; set; }


    }
}