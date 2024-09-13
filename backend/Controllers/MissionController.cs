using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using backend.Data;
using backend.Dtos.Mission;
using backend.Mappers;
using Microsoft.AspNetCore.Http.HttpResults;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Identity.Client;

namespace backend.Controllers
{
    [Route("backend/mission")]
    [ApiController]
    public class MissionController : ControllerBase
    {
        private readonly ApplicationDBContext _context;
        public MissionController(ApplicationDBContext context)
        {
            _context = context; 
        }

        [HttpGet]
        public IActionResult GetAll()
        {
            var mission = _context.Missions.ToList()
            .Select(s => s.toMissionDto()).ToList();

            var result = new 
            {
                Count = mission.Count,
                Data = mission
            };

            return Ok(result);
        }

        [HttpGet("{id}")]
        public IActionResult GetById([FromRoute] int id)
        {
            var mission = _context.Missions.Find(id);

            if(mission == null)
            {
                return NotFound();
            }

            return Ok(mission.toMissionDto());
        }

        [HttpPost]
        public IActionResult Create([FromBody] CreateRequestMissionDto missionDto)
        {
            var missionModel = missionDto.toMissionFromCreateDto();
            _context.Missions.Add(missionModel);
            _context.SaveChanges();
            return CreatedAtAction(nameof(GetById), new { id = missionModel.Id }, missionModel.toMissionDto());
        }

        [HttpPut]
        [Route("{id}")]
        public IActionResult Update([FromRoute] int id, [FromBody] UpdateRequestMissionDto updateRequestMissionDto)
        {
            var missionModel = _context.Missions.FirstOrDefault(x => x.Id == id);
            
            if(missionModel == null)
            {
                return NotFound();
            }

            missionModel.MissionName = updateRequestMissionDto.name;
            missionModel.Description = updateRequestMissionDto.description;
            missionModel.DeadDate = updateRequestMissionDto.deadTime;
            missionModel.Status = updateRequestMissionDto.status;

            _context.SaveChanges();

            return Ok(missionModel.toMissionDto());
        }

        [HttpDelete]
        [Route("{id}")]
        public IActionResult Delete([FromRoute] int id)
        {
            var missionModel = _context.Missions.FirstOrDefault(x => x.Id == id);

            if(missionModel == null)
            {
                return NotFound();
            }

            _context.Missions.Remove(missionModel);
            _context.SaveChanges();

            return NoContent(); 
        }
    }
}