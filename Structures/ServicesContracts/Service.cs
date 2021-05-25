using System;
using System.Collections.Generic;
using Comies.Structures.Filters;
using Comies.Structures.Interfaces;

namespace Comies.Structures.ServicesContracts
{
    public interface Service <Structure, FilterType> where Structure : class where FilterType : Filter
    {
        Response<IEnumerable<Structure>> GetAll();
        Response<IEnumerable<Structure>> GetSome(FilterType filter);
        Response<Structure> GetOne(Guid Id);
        Response<Structure> Save(Structure entity);
        Response<Structure> Update(Structure entity);
        Response<Structure> Remove(int Id);
    }
}
