using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using GisbuyBLProject;
using GisbuyModelProject;
using System.Web.Http.Cors;
//using GisbuyApplication.Models;

namespace GisbuyApplication.Controllers
{
    [EnableCors("http://localhost:4200", "*", "GET,POST,PUT,DELETE")]
   // [IdentityBasicAuthentication] // Enable Basic authentication for this controller.
    //[Authorize] // Require authenticated requests.
    public class ThirdController : ApiController
    {
        GisbuyBl bl = new GisbuyBl();
        // GET: api/Third
        public IEnumerable<GisbuyModel> Get(string email)
        {
            return bl.YourOrders(email);
        }

        // GET: api/Third/5
        // [Authorize]
        
        public IEnumerable<GisbuyModel> Get()
        {
            return bl.GetAllData();
        }

        // POST: api/Third
        public void Post([FromBody]string value)
        {
        }

        // PUT: api/Third/5
        public void Put(int id, [FromBody]string value)
        {
        }

        // DELETE: api/Third/5
        public bool Delete(int statusid)
        {
            bool cancel = false;
            cancel = bl.CancelYourOrders(statusid);
            return cancel;
            
        }
    }
}
