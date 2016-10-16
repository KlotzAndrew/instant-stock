import { List, Map, fromJS } from 'immutable';
import { createStore } from 'redux'

function setPortfolio(state, portfolio) {
  const data = fromJS(portfolio);
  return state.setIn(['portfolio', 'id'], data.getIn(['id']))
              .setIn(['portfolio', 'name'], data.getIn(['attributes', 'name']))
              .setIn(['portfolio', 'cashHoldings'], data.getIn(['relationships', 'cashHoldings', 'data']))
              .setIn(['portfolio', 'stockHoldings'], data.getIn(['relationships', 'stockHoldings', 'data']))
              .setIn(['portfolio', 'stocks'], data.getIn(['relationships', 'stocks', 'data']))
}

function setPortfolioAssociations(state, included) {
  let mutableState = state.toJS();
  included.forEach(obj => {
    if (obj.type === 'stockHoldings') {
      mutableState[obj.type][obj.id] = {
        id: obj.id,
        portfolioId: obj.attributes.portfolioId,
        stockId: obj.attributes.stockId,
        currentTotal: obj.attributes.currentTotal,
        stockTrades: obj.relationships.stockTrades.data
      };
    } else if (obj.type === 'cashHoldings') {
      mutableState[obj.type][obj.id] = {
        id: obj.id,
        portfolioId: obj.attributes.portfolioId,
        currency: obj.attributes.currency,
        currentTotal: obj.attributes.currentTotal,
        cashTrades: obj.relationships.cashTrades.data
      }
    } else if (obj.type === 'stocks') {
      mutableState[obj.type][obj.id] = {
        id: obj.id,
        name: obj.attributes.name,
        currency: obj.attributes.currency,
        ticker: obj.attributes.ticker,
        stockExchange: obj.attributes.stockExchange,
      }
    } else if (obj.type === 'cashTrades') {
      mutableState[obj.type][obj.id] = {
        id: obj.id,
        cashHoldingId: obj.attributes.cashHoldingId,
        createdAt: obj.attributes.createdAt,
        quantity: obj.attributes.quantity,
      }
    } else if (obj.type === 'stockTrades') {
      mutableState[obj.type][obj.id] = {
        id: obj.id,
        stockHoldingId: obj.attributes.stockHoldingId,
        createdAt: obj.attributes.createdAt,
        quantity: obj.attributes.quantity,
        enterPrice: obj.attributes.enterPrice,
      }
    } else if (obj.type === 'minuteBars') {
      let stock = mutableState.stocks[obj.attributes.stockId];
      if (!stock) {
        mutableState.stocks[obj.attributes.stockId] = { id: obj.attributes.stockId }
      }
      stock = mutableState.stocks[obj.attributes.stockId];
      stock[obj.type] = {};
      stock[obj.type][obj.id] = {
        id: obj.id,
        close: obj.attributes.close,
        createdAt: obj.attributes.createdAt,
        high: obj.attributes.high,
        low: obj.attributes.low,
        open: obj.attributes.open,
        quoteTime: obj.attributes.quoteTime,
        stockId: obj.attributes.stockId,
      }
    }
  });
  return fromJS(mutableState)
}

function addMessage(state, message) {
  const newMessage = fromJS(message);
  const newMessages = state.getIn(['portfolio', 'messages']).concat([newMessage]);
  const returnState = state.setIn(['portfolio', 'messages'], newMessages);

  return returnState
}

function addTrade(state, trade) {
  const newTrade = fromJS(trade);

  const tradeId = newTrade.getIn(['data', 'id']);
  const portfolioTrades = state.getIn(['portfolio', 'trades']).concat([tradeId]);

  const tradeState = state.setIn(['trades', tradeId], newTrade.getIn(['data']));
  const portfolioState = tradeState.setIn(['portfolio', 'trades'], portfolioTrades);

  return portfolioState
}

export default function (state = INITIAL_STATE, action) {
  switch (action.type) {
    case 'SET_PORTFOLIO':
      return setPortfolio(state, action.portfolio);
    case 'SET_PORTFOLIO_ASSOCIATIONS':
      return setPortfolioAssociations(state, action.included);
    case 'ADD_MESSAGE':
      return addMessage(state, action.message);
    case 'ADD_TRADE':
      return addTrade(state, action.trade);
  }

  return state;
}

export const INITIAL_STATE = fromJS(
  {
    portfolio: {
      cashHoldings: [],
      stockHoldings: [],
      stocks: [],
      messages: [],
      trades: [],
    },
    trades: {},
    cashHoldings: {},
    stockHoldings: {},
    stocks: {},
    messages: {},
    cashTrades: {},
    stockTrades: {},
  }
);
