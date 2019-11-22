import React from 'react';
import {Link} from 'react-router-dom';
import axios from 'axios';
import { Container, Table , Button} from 'reactstrap';

const apiUrl = 'https://product-order.azurewebsites.net/api/Customers';  

const Customer = props => (
    <tr>
        <td >{props.customer.FullName}</td>
        <td >{props.customer.City}</td>
        <td >{props.customer.Country}</td>   
        <td >{props.customer.State}</td>   
        <td >{props.customer.PostCode}</td>   
        <td >{props.customer.Region}</td>                                      
        
        <td>
            <Button><Link style={{color: "white"}} to={"/edit/" + props.customer.CustID}>Edit</Link></Button> |
            <Button onClick={() => props.deleteCustomer(props.customer.CustID)}>Delete</Button>
        </td>                                       
    </tr>
)

class DisplayCustomers extends React.Component {

    constructor(props) {
        super(props);
        console.log("Constructor created");
    }
    ////Local Url
    state = {
        customers: [],
        //for delete use id parameter to capture custID
        id: ''  
    }

    componentDidMount() {
        console.log("Component did mount");

        ////Local Url
        axios.get(apiUrl)
            //get all the data as promise in the response
            .then(response => {
                const customers = response.data
                this.setState({customers})
            })
            //catch all the errors
            .catch(error => console.log(error)
        )
    }   

    deleteCustomer = id => {
        console.log('delete customers');       
        const { customers } = this.state;
        axios.delete(apiUrl + '/' + id).then(res => {
            alert("Delete the customer's data");
            this.setState({
                response : res,
                //only return customer id. 
                //Whenever the id in the exercise array(in database) does not equal to the id we are deleting. 
                //Just return those id to the customers array
                customers: customers.filter(customer=>customer.CustID !== customer.id)
            })
        })        
    }

    customerList() {        
        //Customer component is declared at the top as a stateless functional component to display all table data
        //2 props - customer and deleteCustomer to Customer child components
        return this.state.customers.map(currentCustomer => {
            return <Customer customer={currentCustomer} 
                            deleteCustomer={this.deleteCustomer}
                            key={currentCustomer._CustID} />
        })
    }
    
    render() {
        console.log("App render");
        console.log(this.state);

        //Using local Url
        //check if there is at least 1 customer in the database (if mo : just display loading..)
        if (this.state.customers.length === 0) {
            return (
                <h2 style={{ textAlign: "center" }}> Loading ......</h2>
            )
        }
        //If at least 1 customer, loop through customers array and display the result
        else {
            return (
                <Container>
                    <div className="table-responsive">
                    <Table dark>
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
                            {this.customerList()}
                        </tbody>
                        </Table>  
                    </div>   
                <Button color="primary"><Link to="/uploadCustomer" style={{color: 'white'}}>Create new Customers</Link></Button>    
            </Container>
            )
        }
    }
}

export default DisplayCustomers;
