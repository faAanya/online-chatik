using Microsoft.AspNetCore.SignalR;

public class ChatHub : Hub
{
    public async Task JoinChat(UserConnection conn)
    {
        await Clients.All
            .SendAsync("Recieved Message", "admin", $"{conn.Username} has joined");
    }

    public async Task JoinSpecificChat(UserConnection conn)
    {
        await Groups
            .AddToGroupAsync(Context.ConnectionId, conn.ChatRoom);

        await Clients
            .Group(conn.ChatRoom)
            .SendAsync(
                "RecievedMessage",
                "admin",
                $"{conn.Username} has joined {conn.ChatRoom}");
    }
}