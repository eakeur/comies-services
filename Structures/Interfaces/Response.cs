using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Comies.Structures.Interfaces
{
    public abstract class Response <T>
    {
        public T Data { get; set; }
    }
}
