
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
    public async Task<ActionResult<User>> Register(UserDTO request, CancellationToken token)
    {
        var user = await authService.RegisterAsync(request, token);
        if (user is null)
            return BadRequest("Phonenumber is already registered");

        return Ok(user);
    }

    [HttpPost("login")]
    public async Task<ActionResult<string>> Login(UserDTO request, CancellationToken token)
    {
        var jwtoken = await authService.LoginAsync(request, token);

        if (jwtoken is null)
            return BadRequest("Invalid phone number");

        return Ok(jwtoken);
    }
}