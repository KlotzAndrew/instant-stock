import { List, Map, fromJS } from 'immutable';
import { createStore } from 'redux'

function setState(state, newState) {
  return state.merge(newState);
}

function resetPortfolio(state) {
  return state;
}

function addMessage(state, message) {
  const newMessage = fromJS(message);
  const newMessages = state.getIn(['messages']).concat([newMessage]);
  const returnState = state.set('messages', newMessages);

  return returnState
}

function addTrade(state, trade) {
  const newTrade = fromJS(trade);
  const newTrades = state.getIn(['trades']).concat([newTrade]);
  const returnState = state.set('trades', newTrades);

  return returnState
}

export default function (state = INITIAL_STATE, action) {
  switch (action.type) {
    case 'SET_PORTFOLIO':
      return resetPortfolio(setState(state, action.state));
    case 'ADD_MESSAGE':
      return addMessage(state, action.message);
    case 'ADD_TRADE':
      return addTrade(state, action.trade);
  }

  return state;
}

export const INITIAL_STATE = fromJS(
  {
    portfolio: null,
    messages: [],
    trades: [],
    cashHoldings: [],
    stockHoldings: []
  }
);
