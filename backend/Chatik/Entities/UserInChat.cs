public class UserInChat
{
    public Guid Id { get; set; }
    public Guid UserId { get; set; }
    public Guid ChatId { get; set; }
    public Role Role { get; set; }
    public DateTime JoinedAt { get; set; }
    public DateTime ExitedAt { get; set; }
    public User User { get; set; } = null!;
    public Chat Chat { get; set; } = null!;
}