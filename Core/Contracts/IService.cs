using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace Comies.Contracts
{
    public interface IService <Structure, View, FilterType> where View : class where Structure : Entity where FilterType : IFilter
    {
        Task<IEnumerable<View>> GetSome(FilterType filter);
        Task<Structure> GetOne(Guid id);
        Task<Structure> Save(Structure entity);
        Task<Structure> Update(Guid id, Structure entity);
        Task<Structure> Remove(Guid id);
        void Validate(Structure entity);
    }
}
