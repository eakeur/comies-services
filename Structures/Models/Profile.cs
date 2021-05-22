using System.Collections.Generic;

namespace comies_services.Structures.Models {
    public class Profile : StoreOwnedEntity
    {
        public int Id { get; set; }
        public string ProfileName { get; set; }
        public string ProfileDescription { get; set; }
        public virtual ICollection<ProfileDetails> ProfileDetails { get; set; }
    }
}