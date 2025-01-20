using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using backend.Dtos;
using backend.Dtos.Mission;
using backend.Models;

namespace backend.Mappers
{
    public static class MissionMapper
    {
        public static MissionDto toMissionDto(this Mission missionModel)
        {
            return new MissionDto
            {
                id = missionModel.Id,
                name = missionModel.MissionName,
                description = missionModel.Description,
                priority = missionModel.Priority,
                createTime = missionModel.CreateDate,
                deadTime = missionModel.DeadDate,
                status = missionModel.Status,
            };
        }

        public static Mission toMissionFromCreateDto(this CreateRequestMissionDto createDto, AppUser user)
        {
            return new Mission
            {
                MissionName = createDto.name,
                Description = createDto.description,
                Priority = createDto.priority,
                CreateDate = createDto.createTime,
                DeadDate = createDto.deadTime,
                Status = createDto.status,  
                AppUser = user,
                AppUserId = user.Id,
            };
        } 
    }
}