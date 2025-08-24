using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddSignalR();

builder.Services.AddControllers();
builder.Services.AddOpenApi();
var connectionString = "Host=localhost;Port=5432;Database=chat;Username=postgres;Password=p2006olina";
builder.Services.AddDbContext<ChatDBContext>(options => options.UseNpgsql(connectionString));
builder.Services.AddCors(opt =>
{
    opt.AddPolicy("reactChatik", builder =>
    {
        builder.WithOrigins("http://localhost:5173")
        .AllowAnyHeader()
        .AllowAnyMethod()
        .AllowCredentials();
    });
});
builder.Services.AddSingleton<SharedDB>();

var app = builder.Build();

if (app.Environment.IsDevelopment())
{
    app.MapOpenApi();
}

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.MapHub<ChatHub>("/chat");
app.UseCors("reactChatik");
app.Run();
