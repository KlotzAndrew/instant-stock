import React, { Component } from 'react';
import {PortfolioContainer} from './components/portfolio';
import axiosInstance from './config/axios';
import {createStore} from 'redux';
import reducer from './reducer';
import { Provider } from 'react-redux';
ActionCable = require('actioncable')

const store = createStore(reducer);
const cable = ActionCable.createConsumer('ws:dockermachine:4000/cable');

cable.subscriptions.create('RoomChannel', {
  connected: function() {
    console.log('connected!')
  },

  disconnected: function() {
    console.log('disconnected!')
  },

  received: function(data) {
    if (data.message !== undefined || data.message !== null) {
      const message = JSON.parse(data.message);
       store.dispatch({
         type: 'ADD_MESSAGE',
         message: message,
       })
    }
  },
});

export default class App extends Component {
  componentDidMount() {
    this._getPromoPortfolio();
  }

  render() {
    return (
      <Provider store={store}>
        <div>
          <PortfolioContainer />
        </div>
      </Provider>
    );
  }

  _getPromoPortfolio = () => {
    function apiCall() {
      return axiosInstance.get('/promo')
                          .then(function(response) {
                            store.dispatch({
                              type: 'SET_PORTFOLIO',
                              state: {
                                portfolio: response.data.portfolio,
                                value: response.data.value,
                              }
                            });
                          })
                          .catch(function(response) {
                            console.log(response);
                          });
    }

    apiCall();
  };
}

