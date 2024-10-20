using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace backend.Helper
{
    public class QueryObject
    {
        public string? Name {get; set;}
        public string? SortBy {get; set;}
        public bool isDescending {get; set;} = false; 
    }
}