using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using backend.Data;
using backend.Dtos.Mission;
using backend.Mappers;
using Microsoft.AspNetCore.Http.HttpResults;
using Microsoft.AspNetCore.Mvc;

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
    }
}