using System;

namespace Comies.Contracts
{
    public interface IAuthenticatedOperator
    {
        Guid StoreId { get; }
        Guid Id { get; }
        Profile Profile { get; }
    }
}