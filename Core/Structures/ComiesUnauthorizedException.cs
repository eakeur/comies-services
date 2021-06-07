using System;
using System.Runtime.Serialization;

namespace Comies {
    public class ComiesUnauthorizedException : UnauthorizedAccessException
    {
        public ComiesUnauthorizedException()
        {
        }

        public ComiesUnauthorizedException(string message) : base(message)
        {
        }

        public ComiesUnauthorizedException(string message, Exception inner) : base(message, inner)
        {
        }

        protected ComiesUnauthorizedException(SerializationInfo info, StreamingContext context) : base(info, context)
        {
        }
    }
}