import React from 'react';
import DisplayCustomers from './components/displayCustomers'
import UploadCustomer from './components/uploadCustomer';

function App() {
  return (
    <div className="container">
      <DisplayCustomers />
      <UploadCustomer />
    </div>
  );
}

export default App;
