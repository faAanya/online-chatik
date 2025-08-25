using Microsoft.EntityFrameworkCore;

public class ChatDBContext : DbContext
{
    public DbSet<User> Users { get; set; }
    public DbSet<Message> Messages { get; set; }
    public DbSet<Chat> Chats { get; set; }
    public DbSet<UserInChat> UsersInChats { get; set; }
    public ChatDBContext(DbContextOptions<ChatDBContext> options)
           : base(options)
    {
        Database.EnsureCreated();
        System.Console.WriteLine("Database has been created");
    }

}