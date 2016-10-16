import { List, Map, fromJS } from 'immutable';
import { createStore } from 'redux'

function setPortfolio(state, portfolio) {
  const data = fromJS(portfolio);
  return state.setIn(['portfolio'], data)
}

function addMessage(state, message) {
  const newMessage = fromJS(message);

  const messageId = newMessage.getIn(['id']);
  const portfolioMessages = state.getIn(['portfolio', 'relationships', 'messages', 'data']).concat([ fromJS({id:messageId}) ]);

  const messagesState = state.setIn(['messages', messageId], newMessage);
  const returnState = messagesState.setIn(['portfolio', 'relationships', 'messages', 'data'], portfolioMessages);

  return returnState
}

function addStockTrade(state, trade) {
  const newTrade = fromJS(trade);

  const tradeId = newTrade.getIn(['data', 'id']);
  const stateWithTrade = state.setIn(['stockTrades', tradeId], newTrade.getIn(['data']));

  const holdingId = newTrade.getIn(['data', 'attributes', 'stockHoldingId']);
  const holdingTotal = state.getIn(['stockHoldings', holdingId, 'attributes', 'currentTotal']);

  const newTotal = holdingTotal + newTrade.getIn(['data', 'attributes', 'quantity']);
  const stateWithHolding = stateWithTrade.setIn(['stockHoldings', holdingId, 'attributes', 'currentTotal'], newTotal);

  return stateWithHolding
}

function addCashTrade(state, trade) {
  const newTrade = fromJS(trade);

  const tradeId = newTrade.getIn(['data', 'id']);
  const stateWithTrade = state.setIn(['cashTrades', tradeId], newTrade.getIn(['data']));

  const holdingId = newTrade.getIn(['data', 'attributes', 'cashHoldingId']);
  const holdingTotal = state.getIn(['cashHoldings', holdingId, 'attributes', 'currentTotal']);

  const newTotal = parseFloat(holdingTotal) + parseFloat(newTrade.getIn(['data', 'attributes', 'quantity']));
  const stateWithHolding = stateWithTrade.setIn(['cashHoldings', holdingId, 'attributes', 'currentTotal'], newTotal.toString());

  return stateWithHolding
}

function setStockHoldings(state, stockHoldings) {
  const newStockHoldings = fromJS(stockHoldings);

  const formattedHoldings = Map(newStockHoldings.map(v => [v.getIn(['id']), v]));
  const returnState = state.setIn(['stockHoldings'], formattedHoldings);

  return returnState
}

function setCashHoldings(state, cashHoldings) {
  const newCashHoldings = fromJS(cashHoldings);

  const formattedHoldings = Map(newCashHoldings.map(v => [v.getIn(['id']), v]));
  const returnState = state.setIn(['cashHoldings'], formattedHoldings);

  return returnState
}

export default function (state = INITIAL_STATE, action) {
  switch (action.type) {
    case 'SET_PORTFOLIO':
      return setPortfolio(state, action.portfolio);
    case 'ADD_MESSAGE':
      return addMessage(state, action.message);
    case 'ADD_STOCK_TRADE':
      return addStockTrade(state, action.trade);
    case 'ADD_CASH_TRADE':
      return addCashTrade(state, action.trade);
    case 'SET_STOCK_HOLDINGS':
      return setStockHoldings(state, action.stockHoldings);
    case 'SET_CASH_HOLDINGS':
      return setCashHoldings(state, action.cashHoldings);
  }

  return state;
}

export const INITIAL_STATE = fromJS(
  {
    portfolio: {
      relationships: {
        messages: {
          data: []
        },
        trades: {
          data: []
        },
        stockHoldings: {
          data: []
        },
      },
    },
    cashHoldings: {},
    stockHoldings: {},
    stocks: {},
    messages: {},
    cashTrades: {},
    stockTrades: {},
  }
);
