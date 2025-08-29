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
 protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);

        var defaultUserId = Guid.NewGuid();

        modelBuilder.Entity<User>().HasData(new User
        {
            Id = defaultUserId,
            UserName = "admin",
            PasswordHash = "123456", // (you should hash in real projects!)
            PhoneNumber = "+10000000000",
            Biography = "I am the default admin user.",
            AvatarUrl = "https://example.com/avatar.png"
        });
    }
}