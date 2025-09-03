public interface IAuthService
{
    Task<User>? RegisterAsync(UserDTO request, CancellationToken token);
    Task<string>? LoginAsync(UserDTO request,CancellationToken token);

}