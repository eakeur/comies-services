using Comies;
using System;
using System.Collections.Generic;
using Comies.Contracts;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace Comies.Controllers
{
    [ApiController]
    public class BaseController<Structure, View, FilterType> : ControllerBase where View : class where Structure : Entity where FilterType : IFilter
    {
        protected readonly IService<Structure, View, FilterType> Service;
        public BaseController(IService<Structure, View, FilterType> service) 
        { 
            Service = service;
        }

        [HttpGet]
        public virtual async Task<ActionResult<IEnumerable<View>>> GetSome([FromQuery] FilterType filter)
        {
            try
            {
                var list = await Service.GetSome(filter); if (list == null) return NotFound();
                Utils.SetTotalCountHeaders(Response, list.Count());
                return Ok(list);
            }
            catch (ComiesArgumentException ex)
            {
                return BadRequest(ex.Message);
            }
            catch (System.Exception e)
            {
                return BadRequest(e.Message);
            }
        }

        [HttpPost]
        public virtual async Task<ActionResult<Structure>> Save(Structure structure)
        {           
            try
            {
                structure = await Service.Save(structure);
                return CreatedAtAction("GetOne", new { id = structure.Id }, structure);
            }
            catch (System.Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [HttpGet("{id}")]
        public virtual async Task<ActionResult<Structure>> GetOne(Guid id)
        {
            try
            {
                var structure = await Service.GetOne(id);
                if (structure == null) return NotFound();
                return Ok(structure);
            }
            catch (ComiesArgumentException ex)
            {
                return BadRequest(ex.Message);
            }
            catch (System.Exception)
            {
                throw new Exception();
            }
        }

        [HttpDelete("{id}")]
        public virtual async Task<IActionResult> Remove(Guid id)
        {           
            try
            {
                await Service.Remove(id);
                return NoContent();
            }
            catch (ComiesArgumentException ex)
            {
                return BadRequest(ex.Message);
            }
            catch (System.Exception)
            {
                throw new Exception();
            }
        }

        [HttpPut("{id}")]
        public virtual async Task<ActionResult<Structure>> Update(Guid id, Structure entity)
        {           
            try
            {
                if (id != entity.Id) return BadRequest();
                await Service.Update(id, entity);
                return NoContent();
            }
            catch (ComiesArgumentException ex)
            {
                return BadRequest(ex.Message);
            }
            catch (System.Exception)
            {
                throw new Exception();
            }
        }
    }
}