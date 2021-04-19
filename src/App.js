import './App.css';
import axios from 'axios';
import React from 'react';



export default class Greetings extends React.Component{
  state = {
    greeting: []
  }

  componentDidMount(){
    axios.get("/greeting",
    {
      headers: {
        'Access-Control-Allow-Origin': 'https://localhost:8080',
      },
    },
    )
      .then(res => {
        const greeting= res.data;
        console.log("+++ some logs +++");
        this.setState({greeting})
      })
  }


  render(){
    return(
      <p>
        greeting should come here:
        {this.state.greeting}
      </p>
    )
  }

}

