using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using backend.Data;
using backend.Dtos;
using backend.Dtos.Mission;
using backend.Interfaces;
using backend.Models;
using Microsoft.EntityFrameworkCore;

namespace backend.Repository
{
    public class MissionRepository : IMissionRepository
    {
        private readonly ApplicationDBContext _context;

        public MissionRepository(ApplicationDBContext context)
        {
            _context = context;
        }

        public async Task<Mission> CreateAsync(Mission missionModel)
        {
            await _context.Missions.AddAsync(missionModel);
            await _context.SaveChangesAsync();
            return missionModel;
        }

        public async Task<Mission?> DeleteAsync(int id)
        {
            var mission = await _context.Missions.FirstOrDefaultAsync(x => x.Id == id); 
            if (mission == null)
            {
                return null;
            }

            _context.Missions.Remove(mission);
            await _context.SaveChangesAsync();  

            return mission;
        }

        public async Task<List<Mission>> GetAllAsync()
        {
            return await _context.Missions.ToListAsync();
        }

        public async Task<List<Mission>> GetByAppUserIdAsync(string appUserId)
        {
            return await _context.Missions.Where(x => x.AppUserId == appUserId).ToListAsync();
        }

        public async Task<Mission?> GetByIdAsync(int id)
        {
            return await _context.Missions.FindAsync(id);
        }

        public async Task<Mission?> UpdateAsync(int id, UpdateRequestMissionDto updateRequestMissionDto)
        {
            var missionModel = await _context.Missions.FirstOrDefaultAsync(x => x.Id == id);
            if (missionModel == null)
            {
                return null;
            }

            missionModel.MissionName = updateRequestMissionDto.name;
            missionModel.Description = updateRequestMissionDto.description;
            missionModel.Priority = updateRequestMissionDto.priority;
            missionModel.DeadDate = updateRequestMissionDto.deadTime;
            missionModel.Status = updateRequestMissionDto.status;

            await _context.SaveChangesAsync();

            return missionModel;
        }
    }
}