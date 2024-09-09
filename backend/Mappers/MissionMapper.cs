using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using backend.Dtos;
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
                Discription = missionModel.Discription,
                CreateDate = missionModel.CreateDate,
                DeadDate = missionModel.DeadDate,
                Status = missionModel.Status,
            };
        }
    }
}