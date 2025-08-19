var builder = WebApplication.CreateBuilder(args);

builder.Services.AddSignalR();

builder.Services.AddControllers();
builder.Services.AddOpenApi();

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
