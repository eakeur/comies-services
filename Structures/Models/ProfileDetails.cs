using System;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
namespace Comies.Structures.Models {
    public class ProfileDetails : StoreOwnedEntity
    {
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)] 
        public Guid Id { get; set; }
        public Guid ProfileId { get; set; }

        [MaxLength(6)]
        public string PermissionCode { get; set; }
        public bool AllowedToAdd { get; set; }
        public bool AllowedToUpdate { get; set; }
        public bool AllowedToDelete { get; set; }
        public bool AllowedToGet { get; set; }
        public bool Allowed { get; set; }
        public virtual Profile Profile { get; set; }
    }
}