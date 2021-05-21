using FluentValidator;
using System;

namespace comies_services.Structures.Models {
    public abstract class PartnerEntity : Notifiable
    {
        public PartnerEntity() { CreationDate = DateTime.Now; }
        public int PartnerId { get; set; }
        public virtual Store Partner { get; set; }
        public bool Active { get; set; }
        public DateTime CreationDate { get; set; }
    }

    public abstract class Entity : Notifiable
    {
        public Entity() { CreationDate = DateTime.Now; }
        public bool Active { get; set; }
        public DateTime CreationDate { get; set; }
    }


}