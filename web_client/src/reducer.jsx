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

export default function (state = INITIAL_STATE, action) {
  switch (action.type) {
    case 'SET_PORTFOLIO':
      return resetPortfolio(setState(state, action.state));
    case 'ADD_MESSAGE':
      return addMessage(state, action.message);
  }

  return state;
}

export const INITIAL_STATE = fromJS({
    portfolio: null,
    messages: []
});
