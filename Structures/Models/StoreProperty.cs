using Comies.Structures.Enumerators;
using System.Collections.Generic;
using System;
using System.ComponentModel.DataAnnotations.Schema;
namespace Comies.Structures.Models
{
    public class StoreProperty : StoreOwnedEntity
    {
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)] 
        public Guid Id { get; set; }
        public Guid ParentId { get; set; }
        public string Key { get; set; }
        public string Value { get; set; }
        public string AllowOverride { get; set; }
        public virtual StoreProperty Parent { get; set; }
        public virtual IList<StoreProperty> Children { get; set; }


    }
}