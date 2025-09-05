public class Chat
{
    public Guid Id { get; set; }
    public string Type { get; set; }
    public string Title { get; set; }
    public Guid CreatorId { get; set; }
    public DateTime CreatedAt { get; set; }
    public User Creator { get; set; } = null!;
    public List<UserInChat> Participants { get; set; } = new List<UserInChat>();
    public List<Message> Messages { get; set; } = new List<Message>();
}