using System.ComponentModel.DataAnnotations;

namespace Comies.Structures.Models {
    public class ProfileDetails : StoreOwnedEntity
    {
        public int Id { get; set; }
        public int ProfileId { get; set; }
        public string PermissionCode { get; set; }
        public bool AllowedToAdd { get; set; }
        public bool AllowedToUpdate { get; set; }
        public bool AllowedToDelete { get; set; }
        public bool AllowedToGet { get; set; }
        public bool Allowed { get; set; }
        public virtual Profile Profile { get; set; }
    }
}