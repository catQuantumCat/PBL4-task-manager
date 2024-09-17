using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace backend.Models
{
    public class Mission
    {
        public int Id { get; set; }
        public string MissionName { get; set; } = string.Empty;
        public string Discription { get; set; } = string.Empty;
        public DateTime CreateDate { get; set; } = DateTime.Now;
        public DateTime DeadDate { get; set; } = DateTime.Now;
        public bool Status { get; set; }
        public int? UserId { get; set; }
        public User? User { get; set; }
    }
}