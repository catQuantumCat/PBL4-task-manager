using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using backend.Dtos;
using backend.Dtos.User;
using backend.Models;

namespace backend.Mappers
{
    public static class UserMapper
    {
        public static UserDto toUserDto(this User user)
        {
            return new UserDto
            {
                Id = user.Id,
                Username = user.Username,
                Password = user.Password,
            };
        }    

        public static User toUserFromCreateDto(this CreateRequestUserDto createRequeseUserDto) 
        {
            return new User
            {
                Username = createRequeseUserDto.Username,
                Password = createRequeseUserDto.Password,
            };
        } 
    }
}