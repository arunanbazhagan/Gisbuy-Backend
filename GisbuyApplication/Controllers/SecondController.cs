using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using GisbuyBLProject;
using GisbuyModelProject;
using System.Web.Http.Cors;
namespace GisbuyApplication.Controllers
{
    [EnableCors("http://localhost:4200", "*", "GET,POST,PUT,DELETE")]
    public class SecondController : ApiController
    {
        GisbuyBl bl = new GisbuyBl();
        // GET: api/Second
      

        // GET: api/Second/5
        public IEnumerable<GisbuyModel> Get(string type)
        {
            return bl.Type(type);
        }
        // POST: api/Second
        //public void Post([FromBody]string value)
        //{
        //}

       

        // DELETE: api/Second/5
        public void Delete(int id)
        {
        }
    }
}
