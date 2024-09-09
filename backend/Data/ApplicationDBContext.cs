using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using backend.Models;
using Microsoft.EntityFrameworkCore;

namespace backend.Data
{
    public class ApplicationDBContext : DbContext
    {
        public ApplicationDBContext (DbContextOptions dbContextOptions)
        :base(dbContextOptions)
        {

        }

        public DbSet<Mission> Missions { get; set;}
        public DbSet<User> Users { get; set;}
        
    }
}