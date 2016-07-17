import React, { Component } from 'react';
import axiosInstance from './config/axios';

export default class App extends Component {
  render() {
    function apiCall() {
      return axiosInstance.get('/promo')
                  .then(function (response) {
                    console.log(response);
                  })
                  .catch(function (response) {
                    console.log(response);
                  });
    }
    apiCall();
    return (
      <h1>Hello, world!</h1>
    );
  }
}
