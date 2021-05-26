using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using Comies.Structures.SecurityModels;
using System.Linq;
using System.Threading.Tasks;

namespace Comies.Controllers
{
    [Route("api/v1/auth")]
    [ApiController]
    public class RegisterController : ControllerBase
    {
        private readonly Core.Contexts.ComiesContext Context;
        public RegisterController(Core.Contexts.ComiesContext context)
        {
            Context = context;
        }

        // GET: api/<RegisterController>
        [HttpGet]
        public IEnumerable<string> Get()
        {
            return new string[] { "value1", "value2" };
        }

        // GET api/<RegisterController>/5
        [HttpGet("{code}")]
        public string Get(int code)
        {
            return "value";
        }

        // POST api/<RegisterController>
        [HttpPost]
        public void Post([FromBody] AuthenticationParameters parameters)
        {

        }

        [HttpPost]
        public void Register([FromBody] string value)
        {
        }

        // PUT api/<RegisterController>/5
        [HttpPut("{id}")]
        public void Put(int id, [FromBody] string value)
        {
        }

        // DELETE api/<RegisterController>/5
        [HttpDelete("{id}")]
        public void Delete(int id)
        {
        }
    }
}
