import React, { Component } from 'react';
import axios from 'axios';
import { Button, Form, FormGroup, Label, Input, Container } from 'reactstrap';

const apiUrl = 'https://product-order.azurewebsites.net/api/Customers';  

export default class UploadCustomer extends Component {
    
    constructor(props){
        super(props);
        console.log("Constructor created");       
    }
    state={
        custID: '',
        segID: '',
        fullname: '',
        city: '',
        country: '',
        state: '',
        postcode: '',
        region: ''
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
            url: apiUrl,
            method: "POST",
            headers:  {
                "Content-Type":"application/json",
                'Access-Control-Allow-Origin': true
              },
              data: customer
        })
        .then(res => {
            console.log('Successfully posted', res)
        })
        .catch(err =>{
            console.log('error while posting the menu', err)
        })
    }

    render() {

    const {custID, fullname, city, state, country, postcode, region, segID} = this.state;

    return (
    <Container  style={{backgroundColor: '#343A40', width: '90%',padding: '4%'}} >
        <Form action="" onSubmit={this.handleSubmit}>
            <FormGroup>
                    <Label htmlFor="CustID" style={{fontWeight: 'bolder', color: 'white'}}>CustomerID</Label>
                        <Input 
                        type="text" 
                        name="custID"
                        value={custID} 
                        onChange={(e) => this.handleChange(e)} />
            </FormGroup>
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
                <Button 
                    type="submit"
                    onClick={this.handleSubmit}
                >
                    Add
                </Button>
            </Form>
        </Container>
        )
    }
}
