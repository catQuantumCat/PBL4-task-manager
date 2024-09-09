using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using backend.Data;
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
    }
}