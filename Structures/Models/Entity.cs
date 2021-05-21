using FluentValidator;
using System;

namespace comies_services.Structures.Models {
    public abstract class StoreOwnedEntity : Notifiable
    {
        public StoreOwnedEntity() { CreationDate = DateTime.Now;}
        public int StoreId { get; set; }
        public virtual Store Store { get; set; }
        public bool Active { get; set; }
        public DateTime CreationDate { get; set; }
    }

    public abstract class Entity : Notifiable
    {
        public Entity() { CreationDate = DateTime.Now;}
        public bool Active { get; set; }
        public DateTime CreationDate { get; set; }
    }


}