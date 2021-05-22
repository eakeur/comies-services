namespace comies_services.Structures.Models
{
    public class Address : StoreOwnedEntity
    {
        public int Id { get; set; }
        public string CEP { get; set; }
        public string Number { get; set; }
        public string District { get; set; }
        public string Complement { get; set; }
        public string Reference { get; set; }
        public string Street { get; set; }
        public string City { get; set; }
        public string State { get; set; }
        public string Country { get; set; }
        public int CostumerId { get; set; }
        public virtual Costumer Costumer { get; set; }
    }
}