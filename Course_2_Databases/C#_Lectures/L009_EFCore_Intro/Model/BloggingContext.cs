using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;

//File scoped namespace
namespace L009_EFCore_Intro.Model;

public class BloggingContext : DbContext
{
    //DbSet says that Blogs will be part of the model.
    public DbSet<Blog> Blogs { get; set; }
    public DbSet<Post> Posts { get; set; }


    // When making a new instance of context this method will run. Default does nothing.
    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
    {
        var connectionString = new SqlConnectionStringBuilder()
        {
            ServerSPN = "localhost",
            InitialCatalog = "BlogDB",
            TrustServerCertificate = true,
            IntegratedSecurity = true
        }.ToString();

        optionsBuilder.UseSqlServer(connectionString);
    }

    //protected override void OnModelCreating(ModelBuilder modelBuilder)
    //{
    //    //Can change properties with Fluent API. Don't need to configure stuff in each class using Fluent API.
    //}
}
