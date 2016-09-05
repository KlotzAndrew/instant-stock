import { List, Map, fromJS, Seq } from 'immutable';
import { expect } from 'chai';
import { INITIAL_STATE } from '../src/reducer';
import _ from 'lodash';

import reducer from '../src/reducer';

describe('reducer', () => {
  it('SET_PORTFOLIO sets portfolio', () => {
    const portfolioId = 'p-123';
    const portfolioName = 'some name';
    const stockHolding = { id: 'sh-123' };
    const cashHolding = { id: 'ch-123' };
    const stock = { id: 's-123' };
    const data = {
      id: portfolioId,
      attributes: { name: portfolioName },
      relationships: {
        cashHoldings: { data: [cashHolding] },
        stockHoldings: { data: [stockHolding] },
        stocks: { data:[stock] }
      }
    };
    const action = {
      type: 'SET_PORTFOLIO',
      portfolio: data,
    };

    const nextState = reducer(INITIAL_STATE, action);

    const portfolio = nextState.getIn(['portfolio']);
    expect(portfolio).to.equal(fromJS({
      id: portfolioId,
      name: portfolioName,
      cashHoldings: [cashHolding],
      stockHoldings: [stockHolding],
      stocks: [stock],
      messages: [],
      trades: [],
    }));
  });

  describe ('SET_PORTFOLIO_ASSOCIATIONS', () => {
    it('sets stockHoldings', () => {
      const stockId = 's-123';
      const portfolioId = 'p-123';
      const stockHoldingId = 'sh-123';
      const currentTotal = '909'
      const stockTrade = { id: 'st-123' };
      const stockHolding = {
        type: 'stockHoldings',
        id: stockHoldingId,
        attributes: {
          portfolioId: portfolioId,
          stockId: stockId,
          currentTotal: currentTotal,
        },
        relationships: {
          stockTrades: { data: [stockTrade] }
        }
      };
      const action = {
        type: 'SET_PORTFOLIO_ASSOCIATIONS',
        included: [stockHolding],
      };
      const nextState = reducer(INITIAL_STATE, action);

      const stockHoldings = nextState.getIn(['stockHoldings']);
      expect(stockHoldings).to.equal(fromJS(
        {
          [stockHoldingId]: {
            id: stockHoldingId,
            portfolioId: portfolioId,
            stockId: stockId,
            currentTotal: currentTotal,
            stockTrades: [stockTrade]
          }
        }
      ));
    });

    it('sets cashHoldings', () => {
      const currency = 'USD';
      const portfolioId = 'p-123';
      const cashHoldingId = 'ch-123';
      const currentTotal = '909';
      const cashTrade = { id: 'st-123' };
      const cashHolding = {
        type: 'cashHoldings',
        id: cashHoldingId,
        attributes: {
          portfolioId: portfolioId,
          currency: currency,
          currentTotal: currentTotal,
        },
        relationships: {
          cashTrades: { data: [cashTrade] }
        }
      };
      const action = {
        type: 'SET_PORTFOLIO_ASSOCIATIONS',
        included: [cashHolding],
      };
      const nextState = reducer(INITIAL_STATE, action);

      const stockHoldings = nextState.getIn(['cashHoldings']);
      expect(stockHoldings).to.equal(fromJS(
        {
          [cashHoldingId]: {
            id: cashHoldingId,
            portfolioId: portfolioId,
            currency: currency,
            currentTotal: currentTotal,
            cashTrades: [cashTrade],
          }
        }
      ));
    });

    it('sets stocks', () => {
      const currency = 'USD';
      const id = 's-123';
      const name = 'some stock';
      const ticker = 'TKR';
      const stockExchange = 'ZZZ';
      const stock = {
        type: 'stocks',
        id: id,
        attributes: {
          name: name,
          currency: currency,
          ticker: ticker,
          stockExchange: stockExchange,
        }
      };
      const action = {
        type: 'SET_PORTFOLIO_ASSOCIATIONS',
        included: [stock]
      };
      const nextState = reducer(INITIAL_STATE, action);

      const stocks = nextState.getIn(['stocks']);
      expect(stocks).to.equal(fromJS(
        {
          [id]: {
            id: id,
            name: name,
            currency: currency,
            ticker: ticker,
            stockExchange: stockExchange,
          }
        }
      ));
    });

    it('sets cash_trades', () => {
      const id = 's-123';
      const cashHoldingId = 'ch-123';
      const createdAt = 'Time.now()';
      const quantity = '808';
      const cashTrade = {
        type: 'cashTrades',
        id: id,
        attributes: {
          cashHoldingId: cashHoldingId,
          createdAt: createdAt,
          quantity: quantity,
        }
      };
      const action = {
        type: 'SET_PORTFOLIO_ASSOCIATIONS',
        included: [cashTrade]
      };
      const nextState = reducer(INITIAL_STATE, action);

      const trade = nextState.getIn(['cashTrades']);
      expect(trade).to.equal(fromJS(
        {
          [id]: {
            id: id,
            cashHoldingId: cashHoldingId,
            createdAt: createdAt,
            quantity: quantity,
          }
        }
      ));
    });

    it('sets stock_trades', () => {
      const id = 's-123';
      const stockHoldingId = 'ch-123';
      const createdAt = 'Time.now()';
      const quantity = '808';
      const enterPrice = '707';
      const stockTrade = {
        type: 'stockTrades',
        id: id,
        attributes: {
          stockHoldingId: stockHoldingId,
          createdAt: createdAt,
          quantity: quantity,
          enterPrice: enterPrice,
        }
      };
      const action = {
        type: 'SET_PORTFOLIO_ASSOCIATIONS',
        included: [stockTrade]
      };
      const nextState = reducer(INITIAL_STATE, action);

      const trade = nextState.getIn(['stockTrades']);
      expect(trade).to.equal(fromJS(
        {
          [id]: {
            id: id,
            stockHoldingId: stockHoldingId,
            createdAt: createdAt,
            quantity: quantity,
            enterPrice: enterPrice,
          }
        }
      ));
    });

    it.only('sets minuteBars', () => {
      const id = 'mb-123';
      const stockHoldingId = 'sh-123';
      const createdAt = 'Time.sometime()';
      const high = '404';
      const low = '101';
      const open = '202';
      const quoteTime = 'Today';
      const stockId = 's-123';
      const minuteBar = {
        type: 'minuteBars',
        id: id,
        attributes: {
          close: stockHoldingId,
          createdAt: createdAt,
          high: high,
          low: low,
          open: open,
          quoteTime: quoteTime,
          stockId: stockId,
        }
      };
      const action = {
        type: 'SET_PORTFOLIO_ASSOCIATIONS',
        included: [minuteBar]
      };
      const nextState = reducer(INITIAL_STATE, action);

      const testt = fromJS({a: 7, b: 2, c: 3})
      const listt = fromJS([{id: 'a'}, {id: 'c'}])
      const newTestt = testt.filter((v, k) => k === 'a')
      const keys = listt.map(k => k.getIn(['id']))

      console.log('newTestt', testt.valueSeq().toJS())
      const bar = nextState.getIn(['stocks', stockId, 'minuteBars']);
      expect(bar).to.equal(fromJS(
        {
          [id]: {
            id: id,
            close: stockHoldingId,
            createdAt: createdAt,
            high: high,
            low: low,
            open: open,
            quoteTime: quoteTime,
            stockId: stockId,
          }
        }
      ));
    });
  });

  it('ADD_MESSAGE adds messages', () => {
    const newMessage = {id: 'm-123', content: 'some content'};
    const action = {
      type: 'ADD_MESSAGE',
      message: newMessage
    };
    const nextState = reducer(INITIAL_STATE, action);

    const portfolioMessages = nextState.getIn(['portfolio', 'messages']);
    expect(portfolioMessages).to.equal(fromJS(
      [newMessage]
    ))
  });

  it('ADD_TRADE adds trade', () => {
    const newTrade = {
      stock_name: 'my stock',
      enter_price: '99.99',
      quantity: '1',
    };
    const action = {
      type: 'ADD_TRADE',
      trade: newTrade,
    };
    const nextState = reducer(INITIAL_STATE, action);

    const trades = nextState.getIn(['portfolio', 'trades']);
    expect(trades).to.equal(fromJS(
      [newTrade]
    ))
  });
});
