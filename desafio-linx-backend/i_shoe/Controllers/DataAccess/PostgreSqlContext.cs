    using Microsoft.EntityFrameworkCore;  
    using PostgresCRUD.Models;  
      
    namespace PostgresCRUD.DataAccess  
    {  
        public class PostgreSqlContext: DbContext  
        {  
            public PostgreSqlContext(DbContextOptions<PostgreSqlContext> options) : base(options)  
            {  
            }  
      
            public DbSet<ShoeItem> shoes { get; set; }  
      
            protected override void OnModelCreating(ModelBuilder builder)  
            {  
                base.OnModelCreating(builder);  
            }  
      
            public override int SaveChanges()  
            {  
                ChangeTracker.DetectChanges();  
                return base.SaveChanges();  
            }  
        }  
    }  
