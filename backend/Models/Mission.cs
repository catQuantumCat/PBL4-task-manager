using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace backend.Models
{
    [Table("Mission")]
    public class Mission
    {
        public int Id { get; set; }
        public string MissionName { get; set; } = string.Empty;
        public string? Description { get; set; } = string.Empty;
        public DateTime CreateDate { get; set; } = DateTime.Now;
        public DateTime DeadDate { get; set; } = DateTime.Now;
        public bool Status { get; set; }
        public string AppUserId { get; set; }
        public AppUser AppUser { get; set; }
    }
}