using System;

namespace Comies.Structures.SecurityModels
{
    public class AuthenticationResponse
    {
        public bool Authenticated { get; set; }
        public DateTime Created { get; set; }
        public DateTime Expiration { get; set; }
        public string AccessToken { get; set; }
        public string Message { get; set; }
        public bool PasswordHasBeenChanged { get; set; }
        public string Access { get; set; }
    }
}