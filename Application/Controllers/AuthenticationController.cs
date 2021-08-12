using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using Microsoft.AspNetCore.Identity;
using System.Threading.Tasks;
using Comies.Auth;

namespace Comies.Controllers
{
    [Route("api/v1/auth")]
    [ApiController]
    public class AuthenticationController : ControllerBase
    {
        private readonly ComiesContext _context;

        private readonly AuthenticationService Service;

        public AuthenticationController(ComiesContext context, AuthenticationService authenticationService)
        {
            _context = context; Service = authenticationService;
        }

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


        [HttpPost]
        public IActionResult Authenticate(
            [FromBody] AuthenticationParameters value, [FromServices] UserManager<ApplicationUser> userManager, [FromServices] SignInManager<ApplicationUser> signInManager)
        {
            try
            {
                var oper = Service.GetOperator(value);
                if (oper == null) return NotFound();
                var token = Service.GetToken(oper, value.KeepConnected);
                Utils.SetAuthorizationHeader(Request, Response, token, Service.ExpirationDate.AddDays(value.KeepConnected ? 1 : 0));
                return NoContent();
            }
            catch (ComiesArgumentException ex)
            {
                return BadRequest(ex.Message);
            }
            catch (ComiesUnauthorizedException ex)
            {
                return Unauthorized(ex.Message);
            }
            catch (System.Exception)
            {
                return StatusCode(500);
            }
        }
    }
}
