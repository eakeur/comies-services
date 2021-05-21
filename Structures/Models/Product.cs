using comies_services.Structures.Enumerators;
namespace comies_services.Structures.Models
{
    public class Product : StoreOwnedEntity
    {
        public int Id { get; set; }
        public string Code { get; set; }
        public string Name { get; set; }
        public string Display { get; set; }
        public Unity SellUnity { get; set; }
        public double Minimum { get; set; }
        public string Tags { get; set; }
        public ProductType Type { get; set; }

}
}