
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.Tokens;
using Microsoft.VisualBasic;

[Route("[controller]")]
[ApiController]
public class AuthenticationController(IAuthService authService) : ControllerBase
{

    public static User user = new();

    [HttpPost("register")]
    public async Task<ActionResult<User>> Register(RegisterDTO request, CancellationToken token)
    {
        user = await authService.RegisterAsync(request, token);
        if (user is null)
            return BadRequest("Phone number is already registered");

        return Ok(user);
    }

    [HttpPost("login")]
    public async Task<ActionResult<string>> Login(LoginDTO request, CancellationToken token)
    {
        var jwtoken = await authService.LoginAsync(request, token);

        if (jwtoken is null)
            return BadRequest("Invalid phone number");

        var logedUser = new
        {
            user.Id,
            user.UserName,
            user.PhoneNumber,
            user.Biography,
            user.AvatarUrl
        };

        return Ok(new { jwtoken, logedUser });
    }
}