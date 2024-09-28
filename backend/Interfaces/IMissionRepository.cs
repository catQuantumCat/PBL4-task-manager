using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using backend.Dtos;
using backend.Dtos.Mission;
using backend.Models;

namespace backend.Interfaces
{
    public interface IMissionRepository
    {
        Task<List<Mission>> GetAllAsync();
        Task<Mission?> GetByIdAsync(int id);
        Task<Mission> CreateAsync(Mission missionModel);
        Task<Mission?> UpdateAsync(int id, UpdateRequestMissionDto updateRequestMissionDto);
        Task<Mission?> DeleteAsync(int id);
    }
}