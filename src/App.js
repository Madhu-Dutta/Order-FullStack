import React from 'react';
import DisplayCustomers from './components/displayCustomers'
import UploadCustomer from './components/uploadCustomer';
import { Container} from 'reactstrap';
function App() {
  return (
    <Container>
      <DisplayCustomers />
      <UploadCustomer />
    </Container>
  );
}

export default App;
