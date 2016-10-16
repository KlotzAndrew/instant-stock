import React, { Component } from 'react';
import {PortfolioContainer} from './components/Portfolio';
import {FullNavbar} from './components/fullNavbar'
import { createStore, applyMiddleware } from 'redux';
import thunk from 'redux-thunk';
import reducer from './reducer';
import { Provider } from 'react-redux';
import ActionCable from 'actioncable';
import serverConfig from '../serverConfig.json';

const store = createStore(
  reducer,
  applyMiddleware(thunk)
);

const cable = ActionCable.createConsumer(`ws:${serverConfig.API_LOCATION}:4000/cable`);

cable.subscriptions.create('RoomChannel', {
  connected: function() {
    console.log('connected!')
  },

  disconnected: function() {
    console.log('disconnected!')
  },

  received: function(data) {
    console.log('data', data)
    if (data.message) {
      const message = JSON.parse(data.message);
       store.dispatch({
         type: 'ADD_MESSAGE',
         message: message,
       })
    } else if (data.trade) {
      const trade = JSON.parse(data.trade);
      store.dispatch({
        type: 'ADD_TRADE',
        trade: trade,
      })
    }
  },
});

export default class App extends Component {
  render() {
    return (
      <Provider store={store}>
        <div>
          <FullNavbar />
          <PortfolioContainer />
        </div>
      </Provider>
    );
  }
}

