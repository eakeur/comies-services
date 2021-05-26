using Comies.Structures.Enumerators;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System;
namespace Comies.Structures.Models
{
    public class Operator : StoreOwnedEntity
    {
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public Guid Id { get; set; }

        [Required(ErrorMessage="Ops! Você precisa informar um nome")]
        [MaxLength(200)]
        public string Name { get; set; }

        [Required(ErrorMessage="Ops! É preciso informar um apelido")]
        [MinLength(3, ErrorMessage="Ops! Seu apelido precisa ter, no mínimo, 3 caracteres")]
        [MaxLength(10, ErrorMessage="Ops! Seu apelido precisa ter, no máximo, 10 caracteres")]
        public string Nickname { get; set; }

        [Required(ErrorMessage="Ops! É preciso informar uma senha")]
        public string Password { get; set; }
        public bool MustChangePassword { get; set; }

        public Guid? ProfileId { get; set; }
        public virtual Profile Profile { get; set; }


    }
}