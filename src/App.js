import React from 'react';
import { BrowserRouter, Route, Switch } from "react-router-dom";

import DisplayCustomers from './components/displayCustomers';
import { Container} from 'reactstrap';
import UploadCustomer from './components/uploadCustomer';

function App() {
  return (
    <BrowserRouter>
      <Container>
          <Switch>
                <Route exact path="/" component={DisplayCustomers} />
                <Route exact path="/uploadCustomer" component={UploadCustomer} />
          </Switch>
      </Container>
    </BrowserRouter>
  );
}

export default App;
