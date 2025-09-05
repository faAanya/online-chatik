public interface IAuthService
{
    Task<User>? RegisterAsync(RegisterDTO request, CancellationToken token);
    Task<string>? LoginAsync(LoginDTO request, CancellationToken token);
}