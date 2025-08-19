import "bootstrap/dist/css/bootstrap.min.css"
import { Col, Container, Row } from "react-bootstrap"
import { WaitingRoom } from "./components/waitingRoom"
import { useState } from "react"
import { HubConnectionBuilder, LogLevel } from "@microsoft/signalr"

function App() {

  const [conn, setConnection] = useState();

  const joinChatRoom = async (userName, chatRoom) => {
    try {
      const conn = new HubConnectionBuilder()
        .withUrl("http://localhost:5037/chat")
        .configureLogging(LogLevel.Information)
        .build();

      conn.on("ReceiveMessage", (userName, message) => {
        console.log("message: ", message);

      });
      await conn.start();
      await conn.invoke("JoinSpecificChat", { userName, chatRoom });
      setConnection(conn);
    } catch (error) {

    }
  }

  return (
    <>
      <main>
        <Container>
          <Row className='px-5 my-5'>
            <Col sm='12'>
              <h1> Welcome to Chatik!</h1>
            </Col>
          </Row>
          <WaitingRoom joinChatRoom={joinChatRoom}></WaitingRoom>
        </Container>
      </main >
    </>
  )
}

export default App
