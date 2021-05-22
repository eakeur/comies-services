namespace comies_services.Structures.Models
{
    public class Phone : StoreOwnedEntity
    {
        public int Id { get; set; }
        public string DDD { get; set; }
        public string Number { get; set; }
        public int CostumerId { get; set; }
        public virtual Costumer Costumer { get; set; }
    }
}