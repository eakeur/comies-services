using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Comies.Structures.Local.Contracts
{
    public class Response<T>
    {
        public bool Success { get; set; }
        public string Message { get; set; }
        public string Exception { get; set; }
        public T Results { get; set; }
        public string Location { get; set; }
        public int TotalRecords { get; set; }

    }
}
