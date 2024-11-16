using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Threading.Tasks;
using backend.Data;
using backend.Dtos;
using backend.Dtos.Mission;
using backend.Extensions;
using backend.Helper;
using backend.Interfaces;
using backend.Mappers;
using backend.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http.HttpResults;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Identity.Client;

namespace backend.Controllers
{
    [Route("backend/mission")]
    [ApiController]
    public class MissionController : ControllerBase
    {
        private readonly IMissionRepository _missionRepo;
        private readonly ITokenService _tokenService;
        private readonly UserManager<AppUser> _userManager;
        public MissionController(IMissionRepository missionRepo, ITokenService tokenService, UserManager<AppUser> userManager)
        {
            _tokenService = tokenService;
            _missionRepo = missionRepo;
            _userManager = userManager;
        }

        [HttpGet]
        [Authorize]
        public async Task<IActionResult> GetAll([FromQuery] QueryObject query)
        {
            var token = Request.Headers["Authorization"].ToString().Replace("Bearer ", "");
            if (_tokenService.isTokenExpired(token))
            {
                return Unauthorized("Token is expired") ;
            }
            
            var userId = await _tokenService.getAppUserIdFromToken(token);
            
            if(string.IsNullOrEmpty(userId))
            {
                return BadRequest("Invalid access token");
            }

            if(userId.Equals("UA"))
            {
                return Unauthorized();
            }

            var mission = await _missionRepo.GetByAppUserIdWithQueryAsync(userId, query);
            
            var result = new 
            {
                Count = mission.Count,
                Data = mission.Select(s => s.toMissionDto()).ToList()
            };

            return Ok(result);
        }

        [HttpPost("GetByUsername")]
        public async Task<IActionResult> GetByUsername([FromBody] string username)
        {
            var user = await _userManager.FindByNameAsync(username);
            
            if(user == null)
            {
                return NotFound();
            }
            
            var mission = await _missionRepo.GetByAppUserIdAsync(user.Id);

            var result = mission.Select(s => s.toMissionDto()).ToList();

            return Ok(result);   
        }

        [HttpGet("{id}")]
        [Authorize]
        public async Task<IActionResult> GetById([FromRoute] int id)
        {
            var mission = await _missionRepo.GetByIdAsync(id);

            if(mission == null)
            {
                return NotFound();
            }

            return Ok(mission.toMissionDto());
        }

        [HttpPost]
        [Authorize]
        public async Task<IActionResult> Create([FromBody] CreateRequestMissionDto missionDto)
        {
            var token = Request.Headers["Authorization"].ToString().Replace("Bearer ", "");
            if (_tokenService.isTokenExpired(token))
            {
                return Unauthorized("Token is expired") ;
            }
            var username = User.GetUsername();
            var appUser = await _userManager.FindByNameAsync(username);
            var missionModel = missionDto.toMissionFromCreateDto(appUser);
            await _missionRepo.CreateAsync(missionModel);
            return CreatedAtAction(nameof(GetById), new { id = missionModel.Id }, missionModel.toMissionDto());
        }

        [HttpPut]
        [Route("{id}")]
        [Authorize]
        public async Task<IActionResult> Update([FromRoute] int id, [FromBody] UpdateRequestMissionDto updateRequestMissionDto)
        {
            var token = Request.Headers["Authorization"].ToString().Replace("Bearer ", "");
            if (_tokenService.isTokenExpired(token))
            {
                return Unauthorized("Token is expired") ;
            }

            var userId = await _tokenService.getAppUserIdFromToken(token);
            
            if(string.IsNullOrEmpty(userId))
            {
                return BadRequest("Invalid access token");
            }

            if(userId.Equals("UA"))
            {
                return Unauthorized();
            }

            var mission = await _missionRepo.GetByAppUserIdAsync(userId);
            if(mission.Count == 0)
            {
                return BadRequest("This user doesn't have any missions to update");
            }

            var updateMission = mission.FirstOrDefault(x => x.Id == id);
            if(updateMission == null)
            {
                return NotFound();
            }
            
            var missionModel = await _missionRepo.UpdateAsync(id, updateRequestMissionDto);
            
            if(missionModel == null)
            {
                return NotFound();
            }

            return Ok(missionModel.toMissionDto());
        }

        [HttpDelete]
        [Route("{id}")]
        [Authorize]
        public async Task<IActionResult> Delete([FromRoute] int id)
        {
            var token = Request.Headers["Authorization"].ToString().Replace("Bearer ", "");
            if (_tokenService.isTokenExpired(token))
            {
                return Unauthorized("Token is expired") ;
            }

            var userId = await _tokenService.getAppUserIdFromToken(token);
            
            if(string.IsNullOrEmpty(userId))
            {
                return BadRequest("Invalid access token");
            }

            if(userId.Equals("UA"))
            {
                return Unauthorized();
            }

            var mission = await _missionRepo.GetByAppUserIdAsync(userId);
            if(mission.Count == 0)
            {
                return BadRequest("This user doesn't have any missions to delete");
            }

            var updateMission = mission.FirstOrDefault(x => x.Id == id);
            if(updateMission == null)
            {
                return NotFound();
            }

            var missionModel = await _missionRepo.DeleteAsync(id);  

            if(missionModel == null)
            {
                return NotFound();
            }

            return NoContent(); 
        }
    }
}