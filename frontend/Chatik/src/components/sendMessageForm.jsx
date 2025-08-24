import { useState } from "react"
import { Form, InputGroup, Button } from "react-bootstrap";
export const SendMessageForm = ({ sendMessage }) => {
    const [msg, setMessage] = useState('');

    return (
        <>
            <Form onSubmit={e => {
                e.preventDefault();
                sendMessage(msg);
                setMessage('');
            }}>
                <InputGroup className="mb-3">
                    <InputGroup.Text>Chat</InputGroup.Text>
                    <Form.Control onChange={e => setMessage(e.target.value)} value={msg} placeholder="type message" />
                    <Button variant="primary" type="submit" disabled={!msg}>Send</Button>
                </InputGroup>
            </Form>
        </>
    )
}