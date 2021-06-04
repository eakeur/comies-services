using System;
using System.Collections.Generic;

namespace Comies.Contracts
{
    public interface IService <Structure, View, FilterType> where View : class where Structure : class where FilterType : IFilter
    {
        IEnumerable<View> GetAll();
        IEnumerable<View> GetSome(FilterType filter);
        Structure GetOne(Guid id);
        Structure Save(Structure entity);
        Structure Update(Guid id, Structure entity);
        Structure Remove(Guid id);
    }
}
