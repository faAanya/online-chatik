public class User
{
    public Guid Id { get; set; }
    public string UserName { get; set; }
    public string PasswordHash { get; set; }
    public string PhoneNumber { get; set; }
    public string Biography { get; set; } = string.Empty;
    public string AvatarUrl { get; set; } = string.Empty;
    public List<UserInChat> Chats { get; set; } = new List<UserInChat>();
    public List<Message> Messages { get; set; } = new List<Message>();
}