using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using backend.Interfaces;
using Microsoft.AspNetCore.Identity;

namespace backend.Services
{
    public class PasswordService : IPasswordService
    {
        public bool VerifyPassword(string hasedPassword, string inputPassword)
        {
            var passwordHasher = new PasswordHasher<IdentityUser>();

            var result = passwordHasher.VerifyHashedPassword(
                null,
                hasedPassword,
                inputPassword
            );

            return result == PasswordVerificationResult.Success;
        }
    }
}