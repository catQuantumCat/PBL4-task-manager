using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace backend.Interfaces
{
    public interface IPasswordService
    {
        public bool VerifyPassword(string hasedPassword, string inputPassword);
    }
}