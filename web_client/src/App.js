import React, { Component } from 'react';
import Portfolio from './components/Portfolio';
import {FullNavbar} from './components/FullNavbar'
import { createStore, applyMiddleware } from 'redux';
import thunk from 'redux-thunk';
import reducer from './reducer';
import { Provider } from 'react-redux';
import ActionCable from 'actioncable';
import serverConfig from '../serverConfig.json';
import * as actions from './actions.jsx'

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
       store.dispatch(actions.addMessage(message))
    } else if (data.stock_trade) {
      const trade = JSON.parse(data.stock_trade);
      store.dispatch(actions.addStockTrade(trade))
    } else if (data.cash_trade) {
      const trade = JSON.parse(data.cash_trade);
      store.dispatch(actions.addCashTrade((trade)))
    }
  },
});

export default class App extends Component {
  render() {
    return (
      <Provider store={store}>
        <div>
          <FullNavbar />
          <Portfolio />
        </div>
      </Provider>
    );
  }
}

