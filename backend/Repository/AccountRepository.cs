using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using backend.Dtos.Account;
using backend.Dtos.Result;
using backend.Interfaces;
using backend.Models;
using Microsoft.AspNetCore.Identity;

namespace backend.Repository
{
    public class AccountRepository : IAccountRepository
    {

        public async Task<ResultDto?> UpdateAsync(EditUserDto editUserDto, UserManager<AppUser> _userManager)
        {
            var user = await _userManager.FindByNameAsync(editUserDto.Username);

            if(user == null)
            {
                return null;
            }
            
            user.Email = editUserDto.Email;
            var removePasswordHash = await _userManager.RemovePasswordAsync(user);
            if(!removePasswordHash.Succeeded)
            {
                return new ResultDto {
                    Success = false,
                    Error = "Failed to remove password"
                };
            }

            var addPasswordHash = await _userManager.AddPasswordAsync(user, editUserDto.Password);
            if(!addPasswordHash.Succeeded)
            {
                return new ResultDto {
                    Success = false,
                    Error = "Failed to add password"
                };
            }
            return new ResultDto {
                Success = true,
                user = user
            };
        }
    }
}