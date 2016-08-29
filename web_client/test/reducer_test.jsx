import { List, Map, fromJS, Seq } from 'immutable';
import { expect } from 'chai';
import { INITIAL_STATE } from '../src/reducer';
import _ from 'lodash';

import reducer from '../src/reducer';

describe('reducer', () => {
  it('SET_PORTFOLIO sets portfolio', () => {
    const initialState = fromJS({});
    const portoflio = {name: 'my_port', cash: '0.0', id: '123-abc'};
    const value = '99';
    const cashHoldings = [{current_total: 99}];
    const stockHoldings = [{current_total: 123}];
    const portfolioMinutes = {'2016-08-27 19:02:00 UTC': '123'};
    const action = {
      type: 'SET_PORTFOLIO',
      state: {
        portfolio: portoflio,
        value: value,
        cashHoldings: cashHoldings,
        stockHoldings: stockHoldings,
        portfolioMinutes: portfolioMinutes
      }
    };
    const nextState = reducer(initialState, action);

    expect(nextState).to.equal(fromJS({
      portfolio: portoflio,
      value: value,
      cashHoldings: cashHoldings,
      stockHoldings: stockHoldings,
      portfolioMinutes: portfolioMinutes
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
  });

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
  });
});
