using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace backend.Dtos
{
    public class MissionDto
    {
        public int Id { get; set; }
        public string MissionName { get; set; } = string.Empty;
        public string Discription { get; set; } = string.Empty;
        public DateTime CreateDate { get; set; } = DateTime.Now;
        public DateTime DeadDate { get; set; } = DateTime.Now;
        public bool Status { get; set; }
    }
}