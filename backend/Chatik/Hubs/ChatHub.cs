using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.SignalR;
using Microsoft.EntityFrameworkCore;

[Authorize]
public class ChatHub : Hub
{
    private MessangerDBContext _dbContext;
    public ChatHub(MessangerDBContext dbContext)
    {
        _dbContext = dbContext;
    }
    public async Task JoinChat(Guid userId, Guid chatId)
    {
        var user = await _dbContext.Users.FindAsync(userId);
        var chat = await _dbContext.Chats.FindAsync(chatId);

        if (user == null || chat == null)
        {
            await Clients.Caller.SendAsync("Error", "Invalid user or chat");
            return;
        }

        var membership = await _dbContext.UsersInChats.FirstOrDefaultAsync(x => x.UserId == userId && x.ChatId == chatId);

        if (membership == null)
        {
            membership = new UserInChat
            {
                Id = Guid.NewGuid(),
                UserId = userId,
                ChatId = chatId,
                Role = Role.Member,
                JoinedAt = DateTime.UtcNow
            };

            _dbContext.UsersInChats.Add(membership);
            await _dbContext.SaveChangesAsync();
        }

        await Groups.AddToGroupAsync(Context.ConnectionId, chatId.ToString());

        await Clients.Group(chatId.ToString())
            .SendAsync("ReceiveMessage", "admin", $"{user.UserName} has joined {chat.Title}");
    }
    public async Task SendMessage(Guid userId, Guid chatId, string msg)
    {
        var user = await _dbContext.Users.FindAsync(userId);
        var chat = await _dbContext.Chats.FindAsync(chatId);

        if (user == null || chat == null)
        {
            await Clients.Caller.SendAsync("Error", "Invalid user or chat");
            return;
        }

        var membership = await _dbContext.UsersInChats
            .FirstOrDefaultAsync(x => x.UserId == userId && x.ChatId == chatId);

        if (membership == null)
        {
            await Clients.Caller.SendAsync("Error", "You are not part of this chat");
            return;
        }

        var message = new Message
        {
            Id = Guid.NewGuid(),
            ChatId = chatId,
            SenderId = userId,
            Content = msg,
            CreatedAt = DateTime.UtcNow
        };

        _dbContext.Messages.Add(message);
        await _dbContext.SaveChangesAsync();

        await Clients.Group(chatId.ToString())
            .SendAsync("ReceiveSpecificMessage", user.UserName, msg, message.CreatedAt);
    }
}