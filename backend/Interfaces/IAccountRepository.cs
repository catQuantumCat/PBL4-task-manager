using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using backend.Dtos.Account;
using backend.Dtos.Result;
using backend.Models;
using Microsoft.AspNetCore.Identity;

namespace backend.Interfaces
{
    public interface IAccountRepository
    {
        Task<ResultDto?> UpdateAsync(EditUserDto editUserDto , UserManager<AppUser> _userManager);
    }
}