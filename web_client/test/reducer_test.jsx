import { List, Map, fromJS } from 'immutable';
import { expect } from 'chai';

import reducer from '../src/reducer';

describe('reducer', () => {
  it('handles SET_PORTFOLIO', () => {
    const initialState = fromJS({})
    const action = {
      type: 'SET_PORTFOLIO',
      state: {
        portfolio: {name: 'my_port', cash: '0.0'}
      }
    };
    const nextState = reducer(initialState, action);

    expect(nextState).to.equal(fromJS({
      portfolio: {
        name: 'my_port',
        cash: '0.0'
      }
    }));
  })
});
