using System;
using System.Runtime.Serialization;

namespace Comies {
    public class ComiesArgumentException : ArgumentException
    {
        public ComiesArgumentException()
        {
        }

        public ComiesArgumentException(string message) : base(message)
        {
        }

        public ComiesArgumentException(string message, Exception innerException) : base(message, innerException)
        {
        }

        public ComiesArgumentException(string message, string paramName) : base(message, paramName)
        {
        }

        public ComiesArgumentException(string message, string paramName, Exception innerException) : base(message, paramName, innerException)
        {
        }

        protected ComiesArgumentException(SerializationInfo info, StreamingContext context) : base(info, context)
        {
        }
    }
}