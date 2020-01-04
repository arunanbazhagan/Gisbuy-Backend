using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Security.Claims;
using Microsoft.IdentityModel.Tokens;

namespace AuthenticationService.Models
{
    public class JWTContainerModel:IAuthContainerModel
    {
        #region Public Methods
        public int ExpireMinutes { get; set; } = 60;
        public string SecretKey { get; set; } = "TW9zaGVFcmCV6UHJpdmF0ZUtleQ==";
        public string SecurityAlgorithm { get; set; } = SecurityAlgorithms.HmacSha256Signature;
        public Claim[] Claims { get; set; }
        #endregion
    }
}
