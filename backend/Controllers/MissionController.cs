using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using backend.Data;
using backend.Dtos.Mission;
using backend.Interfaces;
using backend.Mappers;
using Microsoft.AspNetCore.Http.HttpResults;
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
        public MissionController(IMissionRepository missionRepo)
        {
            _missionRepo = missionRepo;
        }

        [HttpGet]
        public async Task<IActionResult> GetAll()
        {
            var mission = await _missionRepo.GetAllAsync();

            var result = new 
            {
                Count = mission.Count,
                Data = mission.Select(s => s.toMissionDto()).ToList()
            };

            return Ok(result);
        }

        [HttpGet("{id}")]
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
        public async Task<IActionResult> Create([FromBody] CreateRequestMissionDto missionDto)
        {
            var missionModel = missionDto.toMissionFromCreateDto();
            await _missionRepo.CreateAsync(missionModel);
            return CreatedAtAction(nameof(GetById), new { id = missionModel.Id }, missionModel.toMissionDto());
        }

        [HttpPut]
        [Route("{id}")]
        public async Task<IActionResult> Update([FromRoute] int id, [FromBody] UpdateRequestMissionDto updateRequestMissionDto)
        {
            var missionModel = await _missionRepo.UpdateAsync(id, updateRequestMissionDto);
            
            if(missionModel == null)
            {
                return NotFound();
            }

            return Ok(missionModel.toMissionDto());
        }

        [HttpDelete]
        [Route("{id}")]
        public async Task<IActionResult> Delete([FromRoute] int id)
        {
            var missionModel = await _missionRepo.DeleteAsync(id);  

            if(missionModel == null)
            {
                return NotFound();
            }

            return NoContent(); 
        }
    }
}