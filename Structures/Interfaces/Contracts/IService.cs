using System;
using System.Collections.Generic;
using Comies.Structures.Local.Filters;

namespace Comies.Structures.Local.Contracts
{
    public interface IService <Structure, FilterType> where Structure : class where FilterType : IFilter
    {
        IEnumerable<Structure> GetAll();
        IEnumerable<Structure> GetSome(FilterType filter);
        Structure GetOne(Guid id);
        Structure Save(Structure entity);
        Structure Update(Guid id, Structure entity);
        Structure Remove(Guid id);
    }
}
