import React from 'react';
import ReactDOM from 'react-dom';
import Portfolio from './pages/Portfolio';
import Trades from './pages/Trades';
import Bootstrap from 'bootstrap/dist/css/bootstrap.min.css';
import { Provider } from 'react-redux';
import { createStore, applyMiddleware } from 'redux';
import thunk from 'redux-thunk';
import reducer from './reducer';
import { Router, Route, Link, browserHistory } from 'react-router'
import ActionCable from 'actioncable';
import serverConfig from '../serverConfig.json';
import { receiveChannelData } from './actions.jsx'

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
    store.dispatch(receiveChannelData(data));
  },
});

const routes = (
  <div>
    <Route path="/" component={Portfolio} />
    <Route path="/trades" component={Trades} />
  </div>
);

ReactDOM.render(
  <Provider store={store}>
    <Router history={browserHistory}>{routes}</Router>
  </Provider>,
  document.getElementById('root')
);
