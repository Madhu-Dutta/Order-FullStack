import React from 'react';
import { BrowserRouter, Route, Switch } from "react-router-dom";
import { Container} from 'reactstrap';

import DisplayCustomers from './components/displayCustomers';
import UploadCustomer from './components/uploadCustomer';
import EditCustomer from './components/editCustomer';


function App() {
  return (
    <BrowserRouter>
      <Container style={{backgroundColor: '#343A40', padding: '4%'}}>
          <Switch>
                <Route exact path="/" component={DisplayCustomers} />
                <Route exact path="/edit/:id" component={EditCustomer} />
                <Route exact path="/uploadCustomer" component={UploadCustomer} />
          </Switch>
      </Container>
    </BrowserRouter>
  );
}

export default App;
