using Microsoft.AspNetCore.Http;
using System;

namespace Comies.Controllers {
    public class Utils {
        public static void SetTotalCountHeaders(HttpResponse response, int count){
            if (response != null)
                response.Headers.Append("X-Total-Count", count.ToString());
        }
        public static void SetAuthorizationHeader(HttpRequest request, HttpResponse response, string token, DateTime expirationDate)
        {
            if (response != null){
                response.Headers.Append("Authorization", token);
                response.Headers.Append("access-control-expose-headers", "*");
                response.Cookies.Append("Authorization", token, new CookieOptions
                {
                    IsEssential = true,
                    Domain = request.Host.ToString(),
                    Expires = expirationDate
                });
            }
                

        }
    }
}