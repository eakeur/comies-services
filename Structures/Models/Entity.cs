using System.ComponentModel.DataAnnotations;
using System;

namespace Comies.Structures.Models {
    public abstract class StoreOwnedEntity
    {
        public StoreOwnedEntity() { CreationDate = DateTime.Now;}
        
        [Required(ErrorMessage="É preciso especificar uma loja à qual este item pertence")]
        public int StoreId { get; set; }
        public Store Store { get; set; }
        public bool Active { get; set; }
        public DateTime CreationDate { get; set; }
    }

    public abstract class Entity
    {
        public Entity() { CreationDate = DateTime.Now;}
        public bool Active { get; set; }
        public DateTime CreationDate { get; set; }
    }


}