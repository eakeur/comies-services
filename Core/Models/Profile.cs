using System.Collections.Generic;
using System;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
namespace Comies {
    public class Profile : StoreOwnedEntity
    {
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)] 
        public Guid Id { get; set; }

        [MaxLength(50)]
        public string ProfileName { get; set; }

        [MaxLength(100)]
        public string ProfileDescription { get; set; }

        public bool CanAddProducts { get; set; }

        public bool CanPutProducts { get; set; }

        public bool CanGetProducts { get; set; }

        public bool CanDelProducts { get; set; }

        public bool CanAddOrders { get; set; }

        public bool CanPutOrders { get; set; }

        public bool CanGetOrders { get; set; }

        public bool CanDelOrders { get; set; }

        public bool CanAddCustomer { get; set; }

        public bool CanPutCustomer { get; set; }

        public bool CanGetCustomer { get; set; }

        public bool CanDelCustomer { get; set; }

        public bool CanAddStore { get; set; }

        public bool CanPutStore { get; set; }

        public bool CanGetStore { get; set; }

        public bool CanDelStore { get; set; }

        public bool CanAddStock { get; set; }

        public bool CanPutStock { get; set; }

        public bool CanGetStock { get; set; }

        public bool CanDelStock { get; set; }

    }
}