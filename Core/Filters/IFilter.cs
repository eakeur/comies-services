namespace Comies.Contracts
{
    public interface IFilter
    {
        int Skip { get; set; }
        int Take { get; set; }
    }
}
