import React from 'react';
import axios from 'axios';
import { Table , Button} from 'reactstrap';

const apiUrl = 'https://product-order.azurewebsites.net/api/Customers';  

class DisplayCustomers extends React.Component {

    constructor() {
        super();
        console.log("Constructor created");
    }
    ////Local Url
    state = {
        customers: [],
        id: ''  
    }

    componentDidMount() {
        console.log("Component did mount");

        ////Local Url
        axios.get(apiUrl)
            //get all the data as promise in the response
            .then(response => {
                this.setState({
                    customers: response.data
                })
            })
            //catch all the errors
            .catch(error => console.log(error)
        )
    }   

    deleteCustomer = id => {
        console.log('delete customers');       
        const { customers } = this.state;
        axios.delete(apiUrl + '/' + id).then(res => {
            alert("Delete the response data");
            this.setState({
                response : res,
                customers: customers.filter(customer=>customer.CustID !== customer.id)
            })
        })        
    }
    editCustomer = id => {
        console.log('edit customers');
    }
    render() {
        console.log("App render");
        console.log(this.state);

        //Using local Url
        if (this.state.customers.length === 0) {
            return (
                <h2 style={{ textAlign: "center" }}> Loading ......</h2>
            )
        }
        else {
            return (
                <div className="container">
                    <Table dark className="table-container">
                        <thead>
                            <tr>
                                <td>Name</td>
                                <td>City</td>
                                <td>Country</td>
                                <td>State</td>
                                <td>PostCode</td>
                                <td>Region</td>
                            </tr>
                        </thead>
                        <tbody>
                            {this.state.customers.map(customer => {
                                return (
                                        <tr key={customer.CustID}>
                                        <td >{customer.FullName}</td>
                                        <td >{customer.City}</td>
                                        <td >{customer.Country}</td>   
                                        <td >{customer.State}</td>   
                                        <td >{customer.PostCode}</td>   
                                        <td >{customer.Region}</td>                                      
                                         
                                        <td>
                                            <Button onClick={() => this.editCustomer(customer.CustID)}>Edit</Button>
                                        </td> 
                                        <td>
                                            <Button onClick={() => this.deleteCustomer(customer.CustID)}>Delete</Button>
                                        </td>                                       
                                    </tr>
                                )
                            })}
                        </tbody>
                    </Table>                   
            </div>
            )
        }
    }
}

export default DisplayCustomers;
