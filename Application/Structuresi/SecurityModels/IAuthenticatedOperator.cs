using Comies;
using System;

namespace Comies.Structures.SecurityModels
{
    public interface IAuthenticatedOperator
    {
        Guid StoreId {get;}
        Guid Id {get;}
        Profile Profile { get; }
    }
}