using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using backend.Models;

namespace backend.Dtos.Result
{
    public class ResultDto
    {
        public bool Success { get; set; }
        public string Error { get; set; }
        public AppUser user {get; set;} 
    }
}