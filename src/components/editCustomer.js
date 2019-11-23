import React, { Component } from 'react';
import {Link} from 'react-router-dom';
import axios from 'axios';
import { Button, Form, FormGroup, Label, Input, Container } from 'reactstrap';

const apiUrl = 'https://product-order.azurewebsites.net/api/Customers';  

export default class EditCustomer extends Component {
    
    constructor(props){
        super(props);
        console.log("Constructor created");       
    }
    state={
        custID: '',
        segID: 0,
        fullname: '',
        city: '',
        country: '',
        state: '',
        postcode: '',
        region: ''
    }

    componentDidMount() {
        axios
        .get(apiUrl + '/' + this.props.match.params.id)
        .then(res => {
          this.setState({
            custID: res.data.CustID,
            segID: res.data.SegID,
            fullname: res.data.FullName,
            city: res.data.City,
            country: res.data.Country,
            state: res.data.State,
            postcode: res.data.PostCode,
            region: res.data.Region
          });
        })
        .catch(function(err) {
          console.log(err);
        });
    }

    //Onchange
    handleChange = e => {
        const value = e.target.value;
        this.setState({
            ...this.state,
            [e.target.name]: value
        })
        console.log(this.state);
    }

    //OnSubmitting the form
    handleSubmit = (e) => {
        e.preventDefault();

        //body
        const customer = {
            custID: this.state.custID,
            segID: this.state.segID,
            fullname: this.state.fullname,
            state: this.state.state,
            city: this.state.city,
            country: this.state.country,
            postcode: this.state.postcode,
            region: this.state.region
        }
        
        //Post in database            
        axios({
            url: (apiUrl + '/' + this.props.match.params.id),
            method: "PUT",
            headers:  {
                "Content-Type":"application/json",
                'Access-Control-Allow-Origin': true
              },
              data: customer
        })
        .then(res => {
            alert('Successfully posted', res);
        })
        .catch(err =>{
            alert('error while posting the menu', err)
        })
    }

    render() {

    const {custID, fullname, city, state, country, postcode, region, segID} = this.state;

    return (
    <React.Fragment>
    <Container>
        <Form action="" onSubmit={this.handleSubmit}>
        <fieldset disabled>
            <FormGroup>
                    <Label htmlFor="CustID" style={{fontWeight: 'bolder', color: 'white'}}>CustomerID</Label>
                        <Input 
                        type="text" 
                        name="custID"
                        value={custID} 
                        onChange={(e) => this.handleChange(e)} />
            </FormGroup>
            </fieldset>
            <FormGroup>
                    <Label htmlFor="FullName" style={{fontWeight: 'bolder', color: 'white'}}>FullName</Label>
                        <Input 
                        type="text" 
                        name="fullname"
                        value={fullname} 
                        onChange={(e) => this.handleChange(e)} />
                </FormGroup>
                <FormGroup>
                    <Label htmlFor="City" style={{fontWeight: 'bolder', color: 'white'}}>City</Label> 
                        <Input 
                        type="text" 
                        name="city" 
                        value={city} 
                        onChange={(e) => this.handleChange(e)} />
                </FormGroup>
                <FormGroup>
                    <Label htmlFor="Country" style={{fontWeight: 'bolder', color: 'white'}}>Country</Label>
                        <Input 
                        type="text" 
                        name="country" 
                        value={country} 
                        onChange={(e) => this.handleChange(e)} />
                </FormGroup> 
                <FormGroup>
                    <Label htmlFor="State" style={{fontWeight: 'bolder', color: 'white'}}>State</Label>
                        <Input 
                        type="text" 
                        name="state" 
                        value={state} 
                        onChange={(e) => this.handleChange(e)} />
                </FormGroup> 
                <FormGroup>
                    <Label htmlFor="Region" style={{fontWeight: 'bolder', color: 'white'}}>Region</Label>
                        <Input 
                        type="text" 
                        name="region" 
                        value={region} 
                        onChange={(e) => this.handleChange(e)} />
                </FormGroup>      
                <FormGroup>
                    <Label htmlFor="PostCode" style={{fontWeight: 'bolder', color: 'white'}}>PostCode</Label>
                        <Input 
                        type="text" 
                        name="postcode" 
                        value={postcode} 
                        onChange={(e) => this.handleChange(e)} />
                </FormGroup> 
                <FormGroup>
                    <Label htmlFor="Segment ID" style={{fontWeight: 'bolder', color: 'white'}}>Segment ID</Label>
                        <Input 
                        type="text" 
                        name="segID" 
                        value={segID} 
                        onChange={(e) => this.handleChange(e)} />
                </FormGroup>                 
                <Button color="primary" style={{color: 'white'}}
                    type="submit"
                    onClick={this.handleSubmit}
                >
                    Update
                </Button>
            </Form>
            <div style={{marginTop: '4%'}}>
                <Button color="primary"><Link to="/"  style={{color: 'white'}}>View Customers</Link></Button>  
            </div>
        </Container>
       
        </React.Fragment>
        )
    }
}
