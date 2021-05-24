using Comies.Structures.Enumerators;
using System.ComponentModel.DataAnnotations;
using System;
namespace Comies.Structures.Models
{
    public class Operator : StoreOwnedEntity
    {
        public int Id { get; set; }

        [Required(ErrorMessage="Ops! Você precisa informar um nome")]
        public string Name { get; set; }

        [Required(ErrorMessage="Ops! É preciso informar um apelido")]
        [MinLength(3, ErrorMessage="Ops! Seu apelido precisa ter, no mínimo, 3 caracteres")]
        [MaxLength(6, ErrorMessage="Ops! Seu apelido precisa ter, no máximo, 6 caracteres")]
        public string Nickname { get; set; }

        [Required(ErrorMessage="Ops! É preciso informar uma senha")]
        public string Password { get; set; }
        public bool MustChangePassword { get; set; }

        public int ProfileId { get; set; }
        public Profile Profile { get; set; }


    }
}