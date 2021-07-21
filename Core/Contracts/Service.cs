using System;
using System.Linq;
using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace Comies.Contracts
{
    public abstract class Service<Structure, View, FilterType> : IService<Structure, View, FilterType> where View : class where Structure : Entity where FilterType : IFilter
    {

        public ComiesContext Context { get; set; }

        public DbSet<Structure> Collection { get; set; }

        public IAuthenticatedOperator Applicant { get; set; }

        public Service(ComiesContext context, IAuthenticatedOperator applicant)
        {
            Context = context; Applicant = applicant; Collection = Context.Set<Structure>();
        }
        public abstract Task<IEnumerable<View>> GetSome(FilterType filter);
        public virtual async Task<Structure> GetOne(Guid id)
        {
            return await Collection.FirstOrDefaultAsync(x => x.Active && x.Id == id);
        }
        public virtual async Task<Structure> Remove(Guid id)
        {
            var entity = await Collection.FirstOrDefaultAsync(x => true);
            if (entity != null){
                entity.Active = false;
                Collection.Update(entity);
                await Context.SaveChangesAsync();
            }
            return entity;
        }
        public virtual async Task<Structure> Save(Structure entity)
        {
            Validate(entity);
            if (entity.GetType().IsSubclassOf(typeof(StoreOwnedEntity))) entity.GetType().GetProperty("StoreId").SetValue(entity, Applicant.StoreId);
            entity.Active = true;
            Collection.Add(entity);
            await Context.SaveChangesAsync();
            return entity;
        }
        public virtual async Task<Structure> Update(Guid id, Structure entity)
        {
            Validate(entity); entity.Id = id;
            Collection.Update(entity);
            await Context.SaveChangesAsync();
            return entity;
        }
        public virtual void Validate(Structure entity)
        {
            if (entity == null) throw new ArgumentNullException("Ops! O objeto passado é inválido");
        }
    }
}
