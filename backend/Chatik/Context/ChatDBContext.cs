using Microsoft.EntityFrameworkCore;

public class ChatDBContext : DbContext
{
    public DbSet<UserConnection> UserConnections { get; set; }
    public ChatDBContext(DbContextOptions<ChatDBContext> options)
           : base(options)
    {
        Database.EnsureCreated();
        System.Console.WriteLine("Databse has been created");
    }

}