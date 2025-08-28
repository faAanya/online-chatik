using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddSignalR();

builder.Services.AddControllers();
builder.Services.AddOpenApi();
var connectionString = "Host=postgres;Port=5432;Database=onlineChat;Username=postgres;Password=onlineChat";
builder.Services.AddDbContext<ChatDBContext>(options => options.UseNpgsql(connectionString));
var app = builder.Build();

if (app.Environment.IsDevelopment())
{
    app.MapOpenApi();
}

app.UseAuthorization();

app.MapControllers();
app.MapGet("/users", async (ChatDBContext db) =>
    await db.Users.ToListAsync());
app.MapHub<ChatHub>("/chat");
app.Run();
