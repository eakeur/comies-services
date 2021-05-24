using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace Comies.Structures.Models {
    public class Profile : StoreOwnedEntity
    {
        public int Id { get; set; }
        public string ProfileName { get; set; }
        public string ProfileDescription { get; set; }
        public virtual IList<ProfileDetails> ProfileDetails { get; set; }
    }
}