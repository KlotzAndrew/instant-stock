import { List, Map, fromJS } from 'immutable';
import { createStore } from 'redux'

function setState(state, newState) {
  return state.merge(newState);
}

function resetPortfolio(state) {
  return state;
}

export default function (state = Map(), action) {
  switch (action.type) {
    case 'SET_PORTFOLIO':
      return resetPortfolio(setState(state, action.state));
  }

  return state;
}
