public class User
{
    public Guid Id { get; set; }
    public string UserName { get; set; }
    public string PasswordHash { get; set; }
    public string PhoneNumber { get; set; }
    public string Biography { get; set; }
    public string AvatarUrl { get; set; }
}