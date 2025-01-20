using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;
using backend.Interfaces;
using backend.Models;
using Microsoft.AspNetCore.Identity;
using Microsoft.IdentityModel.Tokens;


namespace backend.Services
{
    public class TokenService : ITokenService
    {
        private readonly IConfiguration _config;
        private readonly SymmetricSecurityKey _key;
        private readonly UserManager<AppUser> _userManager;
        public TokenService(IConfiguration config, UserManager<AppUser> userManager)
        {
            _config = config;   
            _key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_config["JWT:SigningKey"]));
            _userManager = userManager;
        }

        public string CreateToken(AppUser user)
        {
            var claims = new List<Claim>
            {
                new Claim(JwtRegisteredClaimNames.Email, user.Email),
                new Claim(JwtRegisteredClaimNames.GivenName, user.UserName),
                new Claim(ClaimTypes.NameIdentifier, user.Id)
            };

            var creds = new SigningCredentials(_key, SecurityAlgorithms.HmacSha512Signature);
            
            var tokenDesciptor = new SecurityTokenDescriptor
            {
                Subject = new ClaimsIdentity(claims),
                Expires = DateTime.Now.AddDays(1),
                SigningCredentials = creds,
                Issuer = _config ["JWT:Issuer"],
                Audience = _config["JWT:Audience"]
            };

            var tokenHandler = new JwtSecurityTokenHandler();

            var token = tokenHandler.CreateToken(tokenDesciptor);

            return tokenHandler.WriteToken(token);
        }

        public async Task<string?> getAppUserIdFromToken(string token)
        {
            if(string.IsNullOrEmpty(token))
                throw new ArgumentNullException(nameof(token));
            
            var handler = new JwtSecurityTokenHandler();

            if(handler.CanReadToken(token))
            {
                var jwtToken = handler.ReadJwtToken(token) as JwtSecurityToken;

                var username = jwtToken.Claims.FirstOrDefault(c => c.Type == "given_name").Value;

                var user = await _userManager.FindByNameAsync(username);

                if(user == null)
                {
                    return "UA";
                }

                var userId = jwtToken.Claims.FirstOrDefault(c => c.Type == "nameid").Value;

                return userId;
            }

            return null;
        }

        public bool isTokenExpired(string token)
        {
            var currentTime = DateTime.UtcNow;
            var tokenHandler = new JwtSecurityTokenHandler();
            var jwtToken = tokenHandler.ReadToken(token) as JwtSecurityToken;
            var exp = jwtToken.ValidTo;
            if (exp < currentTime)
            {
                return true;
            }
            return false;
        }
    }
}