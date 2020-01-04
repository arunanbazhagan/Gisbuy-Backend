using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using GisbuyBLProject;
using GisbuyModelProject;
using System.Web.Http.Cors;
using System.Net.Mail;
//using Authentication.Models;
using Authentication.Managers;
//using System.Security.Claims;
//using GisbuyApplication.Models;
using System.IdentityModel.Tokens.Jwt;


namespace GisbuyApplication.Controllers
{
    [EnableCors("http://localhost:4200","*","GET,POST,PUT,DELETE")]
    
    public class ValuesController : ApiController
    {
        GisbuyBl bl = new GisbuyBl();
        // GET api/values
       public IEnumerable<GisbuyModel> Get(string proid)
        {
            return bl.GetDataFromProduct(proid);
        }
        public bool Get(string adminid,string adminpass)
        {
            bool log = bl.AdminLogin(adminid, adminpass);
            return log;
        }
       // [SkipMyGlobalActionFilter]
        // GET api/values/5
        public bool Post(GisbuyModel user)
        {
            
           bool log = bl.AdminLogin(user.Adminid,user.Adminpass);
            return log;
            //if(log)
            //{
              
            //    IAuthContainerModel model = GetJWTContainerModel(user.Adminid);
            //    IAuthService authService = new JWTService(model.SecretKey);
            //   string token = authService.GenerateToken(model);
            //   var message = Request.CreateResponse(HttpStatusCode.OK, "Authentication successful");
            // message.Headers.Add("JWT_TOKEN", token);
            //  return token;
            //}
            //else
            //{
            //    throw new HttpResponseException(HttpStatusCode.Unauthorized);
            ////    return Request.CreateErrorResponse(HttpStatusCode.Forbidden, "Authentication Failed");
            //}
            
        }



        //POST api/values
        public bool Post([FromBody]GisbuyModel[] model)
        {
            bool added = false;
            added = bl.AddProduct(model);
            return added;
        }

        public bool Post(string email, GisbuyModel model)
        {
            bool added = false;
            // string email = "arunanand307@gmail.com";
            added = bl.AddtoCart(email, model.Proid, model.Proname, model.Proprice, model.Proimage);
            return added;
        }
        // PUT api/values/5
        public bool Put([FromBody]GisbuyModel model)
        {
            bool updated = false;
            updated = bl.UpdateTheProduct(model);
            if(updated)
            {
                MailMessage mail = new MailMessage();
                SmtpClient SmtpServer = new SmtpClient("smtp.gmail.com");

                mail.From = new MailAddress("arunanand307@gmail.com");
                mail.To.Add("ams.khadhiri@gmail.com");
                mail.Subject = "Test Mail";
                mail.Body = "This is for testing SMTP mail from GMAIL";

                SmtpServer.Port = 587;
                SmtpServer.Credentials = new System.Net.NetworkCredential("arunanand307@gmail.com", "TRIPLE A");
                SmtpServer.EnableSsl = true;

                SmtpServer.Send(mail);
                // MessageBox.Show("mail Send");
            }
            return updated;
        }

        // DELETE api/values/5
        public bool Delete(string proid)
        {
            bool deleted = false;
            deleted = bl.DeleteProduct(proid);
            return deleted;
        }
        //#region Private Methods
        //private static JWTContainerModel GetJWTContainerModel(string adminid)
        //{
        //    return new JWTContainerModel()
        //    {
        //        Claims = new Claim[]
        //        {
        //            new Claim(ClaimTypes.Name,adminid)
                    

        //        }
        //    };

        //}
        //#endregion
    }
}
