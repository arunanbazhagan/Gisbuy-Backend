//using System;
//using System.Collections.Generic;
//using System.Linq;
//using System.Web;
//using Authentication.Models;
//using Authentication.Managers;
//using System.Web.Http.Filters;
//using System.Security.Claims;


//namespace GisbuyApplication.Models
//{
//    public class MyGlobalActionFilter : ActionFilterAttribute
//    {
//        public override void OnActionExecuting(System.Web.Http.Controllers.HttpActionContext filterContext)
//        {
//            if (filterContext.ActionDescriptor.GetCustomAttributes<SkipMyGlobalActionFilterAttribute>().Any())
//            {
//                return;
//            }
//            if (!filterContext.Request.Headers.Contains("JWT_TOKEN"))
//                throw new UnauthorizedAccessException();
//            else
//            {
//                String token = filterContext.Request.Headers.GetValues("JWT_TOKEN").First();
//                IAuthContainerModel model = new JWTContainerModel();
//                IAuthService authService = new JWTService(model.SecretKey);
//                if (!authService.IsTokenValid(token))
//                    throw new UnauthorizedAccessException();
//                else
//                {
//                    List<Claim> claims = authService.GetTokenClaims(token).ToList();

//                    Console.WriteLine(claims.FirstOrDefault(e => e.Type.Equals(ClaimTypes.Name)).Value);
                    
                    
//                }
//            }
//        }
//    }

//    public class SkipMyGlobalActionFilterAttribute : Attribute
//    {
//    }
//}