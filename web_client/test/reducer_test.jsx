import { List, Map, fromJS, Seq } from 'immutable';
import { expect } from 'chai';
import { INITIAL_STATE } from '../src/reducer';
import _ from 'lodash';

import reducer from '../src/reducer';

describe('reducer', () => {
  describe('SET_PORTFOLIO', () => {
    it('sets store portfolio', () => {
      const newPortfolio = {
        id: 'p123',
        type: 'portfolios',
        attributes: {
          name: '999',
        },
        relationships: {}
      };
      const action = {
        type: 'SET_PORTFOLIO',
        portfolio: newPortfolio,
      };
      const nextState = reducer(INITIAL_STATE, action);

      const portfolio = nextState.getIn(['portfolio']);
      expect(portfolio).to.equal(fromJS(
        newPortfolio
      ));
    });
  });

  describe('ADD_MESSAGE', () => {
    it('adds messages to store', () => {
      const newMessage = {id: 'm-123', content: 'some content'};
      const action = {
        type: 'ADD_MESSAGE',
        message: newMessage
      };
      const nextState = reducer(INITIAL_STATE, action);

      const portfolioMessages = nextState.getIn(['portfolio', 'relationships', 'messages', 'data']);
      expect(portfolioMessages).to.equal(fromJS(
        [ {id: newMessage.id} ]
      ));

      const message = nextState.getIn(['messages', newMessage.id]);
      expect(message).to.equal(fromJS(
        newMessage
      ));
    });
  });

  describe('ADD_TRADE', () => {
    const tradeId = 'trade1';
    const stockHoldingId = 'holding1';
    const newTrade = {
      data: {
        type: 'stockTrades',
        id: tradeId,
        attributes: {
          stockName: 'my stock',
          enterPrice: '99.99',
          quantity: 1,
          stockHoldingId: stockHoldingId,
        },
        relationships: {
          stockHolding: {
            data: {
              id: stockHoldingId,
            }
          }
        }
      }
    };
    const action = {
      type: 'ADD_TRADE',
      trade: newTrade,
    };

    it('adds trade to store', () => {
      const nextState = reducer(INITIAL_STATE, action);

      const trades = nextState.getIn(['trades', tradeId]);
      expect(trades).to.equal(fromJS(
        newTrade.data
      ))
    });

    it('adjusts stockHolding currentTotal', () => {
      const stockHolding = {
        id: stockHoldingId,
        attributes: {
          currentTotal: 999,
        }
      };
      const testState = INITIAL_STATE.setIn(['stockHoldings', stockHoldingId], fromJS(stockHolding))

      const nextState = reducer(testState, action);

      const newTotal = nextState.getIn(['stockHoldings', stockHoldingId, 'attributes', 'currentTotal']);
      expect(newTotal).to.equal(fromJS(
        1000
      ))
    })
  });

  describe('SET_STOCK_HOLDINGS', () => {
    it('adds stockHoldings to store', () => {
      const newStockHolding = {
        id: 'sh123',
        type: 'stockHoldings',
        attributes: {
          currentTotal: 999,
          portfolioId: 'pabc',
          stockId: 'sabc',
        },
        relationships: {}
      }
      const newStockHoldings = [
        newStockHolding
      ];
      const action = {
        type: 'SET_STOCK_HOLDINGS',
        stockHoldings: newStockHoldings,
      };
      const nextState = reducer(INITIAL_STATE, action);

      const stockHoldings = nextState.getIn(['stockHoldings', newStockHolding.id]);
      expect(stockHoldings).to.equal(fromJS(
        newStockHolding
      ));
    })
  });
});
