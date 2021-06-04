using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using Microsoft.AspNetCore.Http;
using Comies.Contracts;
using Comies;

namespace Comies.Structures.SecurityModels
{
    public class AuthenticatedOperator : IAuthenticatedOperator
    {
        private readonly IHttpContextAccessor _accessor;

        public AuthenticatedOperator(IHttpContextAccessor accessor)
        {
            _accessor = accessor;
        }

        public Guid StoreId => Guid.Parse(Claims.Where(x => x.Type == "StoreId").FirstOrDefault().Value);

        public Guid Id => Guid.Parse(Claims.Where(x => x.Type == "OperatorId").FirstOrDefault().Value);

        public string Name => Claims.Where(x => x.Type == "Nickname").FirstOrDefault().Value;

        public Profile Profile => new Profile();
            
        public IEnumerable<Claim> Claims => _accessor.HttpContext.User.Claims;
        
    }
}