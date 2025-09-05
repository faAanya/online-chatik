
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;

public class AuthService(MessangerDBContext context, IConfiguration configuration) : IAuthService
{
    public async Task<User>? RegisterAsync(RegisterDTO request, CancellationToken token)
    {
        var hasUser = await context.Users.AsNoTracking().AnyAsync(u => u.PhoneNumber == request.PhoneNumber, token);
        if (hasUser)
        {
            return null;
        }

        var user = new User();

        var hashedPassword = new PasswordHasher<User>().HashPassword(user, request.Password);
        user.UserName = request.UserName;
        user.PasswordHash = hashedPassword;
        user.PhoneNumber = request.PhoneNumber;

        await context.Users.AddAsync(user, token);
        await context.SaveChangesAsync(token);
        return user;
    }
    public async Task<string>? LoginAsync(LoginDTO request, CancellationToken token)
    {
        var user = await context.Users.AsNoTracking().FirstOrDefaultAsync(u => u.PhoneNumber == request.PhoneNumber);

        if (user is null)
        {
            return null;
        }
        if (new PasswordHasher<User>().VerifyHashedPassword(user, user.PasswordHash, request.Password)
            == PasswordVerificationResult.Failed)
        {
            return null;
        }

        return CreateToken(user);
    }
    
    private string CreateToken(User user)
    {
        var claims = new List<Claim>()
        {
            new Claim(ClaimTypes.Name, user.UserName),
            new Claim(ClaimTypes.NameIdentifier, user.Id.ToString())
        };

        var key = new SymmetricSecurityKey(
            Encoding.UTF8.GetBytes(configuration.GetValue<string>("AppSettings:Token")!)
        );

        var credentials = new SigningCredentials(key, SecurityAlgorithms.HmacSha512);

        var tokenDescriptor = new JwtSecurityToken(
            issuer: configuration.GetValue<string>("AppSettings: Issuer"),
            audience: configuration.GetValue<string>("AppSettings: Audience"),
            claims: claims,
            expires: DateTime.UtcNow.AddDays(60),
            signingCredentials: credentials
        );

        return new JwtSecurityTokenHandler().WriteToken(tokenDescriptor);
    }

}