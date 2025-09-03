using Microsoft.EntityFrameworkCore;

public class MessangerDBContext : DbContext
{
    public DbSet<User> Users { get; set; }
    public DbSet<Message> Messages { get; set; }
    public DbSet<Chat> Chats { get; set; }
    public DbSet<UserInChat> UsersInChats { get; set; }
    public MessangerDBContext(DbContextOptions<MessangerDBContext> options)
           : base(options)
    {
        Database.EnsureCreated();
        System.Console.WriteLine("Database has been created");
    }
 protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);
    }
}