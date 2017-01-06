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
import { Socket } from 'phoenix-socket';
import serverConfig from '../serverConfig.json';
import { receiveChannelData } from './actions.jsx'

const store = createStore(
  reducer,
  applyMiddleware(thunk)
);

let socket = new Socket(`ws:${serverConfig.API_LOCATION}:4000/socket`)
socket.connect()

let channel = socket.channel('room:lobby', {});

channel.on('new:msg', payload => {
  console.log('data', payload);
  store.dispatch(receiveChannelData(payload));
  }
);

channel.join()
  .receive('ok', resp => { console.log('Joined successfully', resp) })
  .receive('error', resp => { console.log('Unable to join', resp) })

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
