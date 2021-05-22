using comies_services.Structures.Enumerators;
using FluentValidator;
using System;
namespace comies_services.Structures.Models
{
    public class Operator : StoreOwnedEntity
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Nickname { get; set; }
        public string Password { get; set; }
        public int ProfileId { get; set; }
        public Profile Profile { get; set; }


    }
}