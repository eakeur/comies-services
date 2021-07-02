using System;
using System.Runtime.Serialization;

namespace Comies {
    public class ComiesNotFoundException : NullReferenceException
    {
        public ComiesNotFoundException()
        {
        }

        public ComiesNotFoundException(string message) : base(message)
        {
        }

        public ComiesNotFoundException(string message, Exception innerException) : base(message, innerException)
        {
        }

        protected ComiesNotFoundException(SerializationInfo info, StreamingContext context) : base(info, context)
        {
        }
    }
}