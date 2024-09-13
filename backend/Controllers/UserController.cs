using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using backend.Data;
using backend.Dtos.User;
using backend.Mappers;
using Microsoft.AspNetCore.Http.HttpResults;
using Microsoft.AspNetCore.Mvc;

namespace backend.Controllers
{
    [Route("backend/user")]
    [ApiController]
    public class UserController : ControllerBase
    {
        private readonly ApplicationDBContext _context;
        public UserController(ApplicationDBContext context)
        {
            _context = context; 
        }

        [HttpGet]
        public IActionResult GetAll()
        {
            var users = _context.Users.ToList()
            .Select(s => s.toUserDto());
            return Ok(users);
        }

        [HttpGet("{id}")]
        public IActionResult GetById([FromRoute] int id)
        {
            var user = _context.Users.Find(id);

            if(user == null)
            {
                return NotFound();
            }

            return Ok(user.toUserDto());
        }

        [HttpPost]
        public IActionResult Create([FromBody] CreateRequeseUserDto userDto)
        {
            var user = userDto.toUserFromCreateDto();
            _context.Users.Add(user);
            _context.SaveChanges();
            return CreatedAtAction(nameof(GetById), new {id = user.Id}, user.toUserDto());    
        }

        [HttpPut]
        [Route("{id}")]
        public IActionResult Update ([FromRoute] int id,[FromBody] UpdateRequestUserDto updateRequestUserDto)
        {
            var userModel = _context.Users.FirstOrDefault(x => x.Id == id);

            if(userModel == null)
            {
                return NotFound();
            }

            userModel.Username = updateRequestUserDto.Username;
            userModel.Password = updateRequestUserDto.Password;

            _context.SaveChanges();

            return Ok(userModel.toUserDto());
        }

        [HttpDelete]
        [Route("{id}")]
        public IActionResult Delete([FromRoute] int id)
        {
            var userModel = _context.Users.FirstOrDefault(x => x.Id == id);

            if(userModel == null)
            {
                return NotFound();
            }

            _context.Users.Remove(userModel);
            _context.SaveChanges();

            return NoContent();
        }
    }
}