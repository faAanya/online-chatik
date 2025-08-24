export const MessageContainer = ({ messages }) => {
    return (
        <>
            {
                <ul className="list-unstyled">
                    {messages.map((msg, index) => (
                        <li key={index}>
                            <strong>{msg.userName}</strong>: {msg.message}
                        </li>
                    ))}
                </ul>
            }
        </>
    )
}