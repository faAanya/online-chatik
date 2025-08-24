using System.Collections.Concurrent;

public class SharedDB
{
    private readonly ConcurrentDictionary<string, UserConnection> _connections = new ConcurrentDictionary<string, UserConnection>();
    public ConcurrentDictionary<string, UserConnection> Connections => _connections;
}