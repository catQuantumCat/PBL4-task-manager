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
                Id = missionModel.Id,
                MissionName = missionModel.MissionName,
                Discription = missionModel.Discription,
                CreateDate = missionModel.CreateDate,
                DeadDate = missionModel.DeadDate,
                Status = missionModel.Status,
            };
        }

        public static Mission toMissionFromCreateDto(this CreateRequestMissionDto createDto)
        {
            return new Mission
            {
                MissionName = createDto.MissionName,
                Discription = createDto.Discription,
                CreateDate = createDto.CreateDate,
                DeadDate = createDto.DeadDate,
                Status = createDto.Status,  
            };
        } 
    }
}