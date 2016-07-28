import { List, Map, fromJS } from 'immutable';
import { expect } from 'chai';
import { INITIAL_STATE } from '../src/reducer'

import reducer from '../src/reducer';

describe('reducer', () => {
  it('SET_PORTFOLIO sets portfolio', () => {
    const initialState = fromJS({});
    const action = {
      type: 'SET_PORTFOLIO',
      state: {
        portfolio: {name: 'my_port', cash: '0.0', id: '123-abc'}
      }
    };
    const nextState = reducer(initialState, action);

    expect(nextState).to.equal(fromJS({
      portfolio: {
        name: 'my_port',
        cash: '0.0',
        id: '123-abc'
      }
    }));
  });

  it('ADD_MESSAGE adds messages', () => {
    const newMessage = {content: 'some content'};
    const action = {
      type: 'ADD_MESSAGE',
      message: newMessage
    };
    const nextState = reducer(INITIAL_STATE, action);

    const messages = nextState.getIn(['messages']);
    expect(messages).to.equal(fromJS(
      [newMessage]
    ))
  })

  it('ADD_TRADE adds trade', () => {
    const newTrade = {
      stock_name: 'my stock',
      enter_price: '99.99',
      quantity: '1'
    };
    const action = {
      type: 'ADD_TRADE',
      trade: newTrade
    };
    const nextState = reducer(INITIAL_STATE, action);

    const trades = nextState.getIn(['trades']);
    expect(trades).to.equal(fromJS(
      [newTrade]
    ))
  })
});
