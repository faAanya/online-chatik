import "bootstrap/dist/css/bootstrap.min.css"
import { Col, Container, Row } from "react-bootstrap"

function App() {
  return (
    <>
      <main>
        <Container>
          <Row class='px-5 my-5'>
            <Col sm='12'>
              <h1> Welcome to Chatik!</h1>
            </Col>
          </Row>
        </Container>
      </main >
    </>
  )
}

export default App
