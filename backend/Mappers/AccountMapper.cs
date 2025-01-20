using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using backend.Dtos.Account;

namespace backend.Mappers
{
    public static class AccountMapper
    {
        public static EditUserDto toEditUserDto(this EditUserClientDto editUserClientDto)
        {
            return new EditUserDto
            {
                Username = editUserClientDto.Username,
                Password = editUserClientDto.NewPassword,
                Email = editUserClientDto.Email,
            };
        }
    }
}