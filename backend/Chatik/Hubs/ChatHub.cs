using Microsoft.AspNetCore.SignalR;

public class ChatHub : Hub
{
    private ChatDBContext _dbContext;
    private readonly SharedDB _shared;
    public ChatHub(SharedDB shared)
    {
        _shared = shared;
    }
    public async Task JoinChat(UserConnection conn)
    {
        await Clients.All
            .SendAsync("ReceiveMessage", "admin", $"{conn.Username} has joined");
    }

    public async Task JoinSpecificChat(UserConnection conn)
    {
        await Groups
            .AddToGroupAsync(Context.ConnectionId, conn.ChatRoom);

        _shared.Connections[Context.ConnectionId] = conn;

        await Clients
            .Group(conn.ChatRoom)
            .SendAsync(
                "ReceiveMessage",
                "admin",
                $"{conn.Username} has joined {conn.ChatRoom}");
    }

    public async Task SendMessage(string msg)
    {
        if (_shared.Connections.TryGetValue(Context.ConnectionId, out UserConnection conn))
        {
            await Clients.Group(conn.ChatRoom)
           .SendAsync("ReceiveSpecificMessage", conn.Username, msg);
        }
    }
}