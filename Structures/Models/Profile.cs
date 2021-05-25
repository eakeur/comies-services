using System.Collections.Generic;
using System;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
namespace Comies.Structures.Models {
    public class Profile : StoreOwnedEntity
    {
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)] 
        public Guid Id { get; set; }

        [MaxLength(50)]
        public string ProfileName { get; set; }

        [MaxLength(100)]
        public string ProfileDescription { get; set; }
        public virtual IList<ProfileDetails> ProfileDetails { get; set; }
    }
}