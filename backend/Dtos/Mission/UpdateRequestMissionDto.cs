using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace backend.Dtos.Mission
{
    public class UpdateRequestMissionDto
    {
        public string name { get; set; } = string.Empty;
        public string? description { get; set; }
        public DateTime deadTime { get; set; } = DateTime.Now;
        public bool status { get; set; } = false;
    }
}