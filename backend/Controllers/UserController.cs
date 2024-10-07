using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using backend.Data;
using backend.Dtos.User;
using backend.Interfaces;
using backend.Mappers;
using Microsoft.AspNetCore.Http.HttpResults;
using Microsoft.AspNetCore.Mvc;

namespace backend.Controllers
{
    [Route("backend/user")]
    [ApiController]
    public class UserController : ControllerBase
    {
        private readonly IUserRepository _userRepo;
        public UserController(IUserRepository userRepo)
        {
             _userRepo = userRepo;
        }

        [HttpGet]
        public async Task<IActionResult> GetAll()
        {
            var users = await _userRepo.GetAllAsync();
            return Ok(users);
        }

        [HttpGet("{id}")]
        public async Task<IActionResult> GetById([FromRoute] int id)
        {
            var user = await _userRepo.GetByIdAsync(id);

            if(user == null)
            {
                return NotFound();
            }

            return Ok(user);
        }

        [HttpPost]
        public async Task<IActionResult> Create([FromBody] CreateRequestUserDto userDto)
        {
            var user = userDto.toUserFromCreateDto();
            await _userRepo.CreateAsync(user);
            return CreatedAtAction(nameof(GetById), new {id = user.Id}, user.toUserDto());    
        }

        [HttpPut]
        [Route("{id}")]
        public async Task<IActionResult> Update ([FromRoute] int id,[FromBody] UpdateRequestUserDto updateRequestUserDto)
        {
            var userModel = await _userRepo.UpdateAsync(id, updateRequestUserDto);

            if(userModel == null)
            {
                return NotFound();
            }

            return Ok(userModel.toUserDto());
        }

        [HttpDelete]
        [Route("{id}")]
        public async Task<IActionResult> Delete([FromRoute] int id)
        {
            var userModel = await _userRepo.DeleteAsync(id);

            if(userModel == null)
            {
                return NotFound();
            }

            return NoContent();
        }
    }
}