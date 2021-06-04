using Microsoft.AspNetCore.Http;
namespace Comies.Controllers {
    public class Utils {
        public static void SetTotalCountHeaders(HttpResponse response, int count){
            if (response != null)
                response.Headers.Append("X-Total-Count", count.ToString());
        }
    }
}