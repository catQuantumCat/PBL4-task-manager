using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace backend.Dtos
{
    public class MissionDto
    {
        public int id { get; set; }
        public string name { get; set; } = string.Empty;
        public string? description { get; set; } = string.Empty;
        public int? priority { get; set; } = 0;
        public DateTime createTime { get; set; } = DateTime.Now;
        public DateTime deadTime { get; set; } = DateTime.Now;
        public bool status { get; set; } = false;
    }
}