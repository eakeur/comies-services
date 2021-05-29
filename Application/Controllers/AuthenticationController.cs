using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Comies;
using Comies.Services;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace Comies.Controllers
{
    [Route("api/v1/auth")]
    [ApiController]
    public class AuthenticationController : ControllerBase
    {
        private readonly ComiesContext _context;

        private readonly AuthenticationService _authenticationService;

        public AuthenticationController(ComiesContext context, AuthenticationService authenticationService)
        {
            _context = context; _authenticationService = authenticationService;
        }


        // GET: api/<AuthenticationController>
        [HttpGet("register/template")]
        public async Task<ActionResult<Store>> Get()
        {
            var store = await _context.Stores.AddAsync(new Store {
                Name = "Dinhas's Grill", CompanyName = "Espetinhos e Lanches da Dinha", CompanyNickname = "dinhas", ContactName = "Thiago Soares", 
                MemberSince = DateTime.Now, Active = true
            
            });

            var oper = await _context.Operators.AddAsync(new Operator
            {
                Name = "Igor de Souza Reis",
                Nickname = "igor",
                Password = "12345678",
                StoreId = store.Entity.Id,
                Active = true,
                MustChangePassword = false
            });

            await _context.SaveChangesAsync();
            store.Entity.Operators = new List<Operator>();
            store.Entity.Operators.Add(oper.Entity);
            return store.Entity;
        }

        // GET api/<AuthenticationController>/5
        [HttpGet("test")]
        public string Gety()
        {
            return "Ok";
        }

        // POST api/<AuthenticationController>
        [HttpPost]
        public void Post([FromBody] Structures.SecurityModels.AuthenticationParameters value)
        {
            var product = _authenticationService.GetOperator(value);
        }

        // PUT api/<AuthenticationController>/5
        [HttpPut("{id}")]
        public void Put(int id, [FromBody] string value)
        {
        }

        // DELETE api/<AuthenticationController>/5
        [HttpDelete("{id}")]
        public void Delete(int id)
        {
        }
    }
}
