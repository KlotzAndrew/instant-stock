import portfolioApi from './api/portfolio.jsx';
import stockHoldingsApi from './api/portfolioStockHoldings.jsx'
import cashHoldingsApi from './api/portfolioCashHoldings.jsx'
import * as types from './ActionTypes'

export function setPromoPortfolio() {
  return dispatch => {
    portfolioApi.getPromoPortfolio()
      .then(response => {
        dispatch(setPortfolio(response.data.data));
        dispatch(setPortfolioCashHoldings(response.data.data.id));
        dispatch(setPortfolioStockHoldings(response.data.data.id));
      })
      .catch(response => {
        console.log('portfolio failed!', response)
      })
  }
}

export function setPortfolioCashHoldings(portfolioId) {
  return dispatch => {
    cashHoldingsApi.getPortfolioCashHoldings(portfolioId)
                    .then(response => {
                      dispatch(setCashHoldings(response.data.data));
                    })
                    .catch(response => {
                      console.log('cash holdings failed!', response);
                    })
  }
}

export function setPortfolioStockHoldings(portfolioId) {
  return dispatch => {
    stockHoldingsApi.getPortfolioStockHoldings(portfolioId)
      .then(response => {
        dispatch(setStockHoldings(response.data.data));
      })
      .catch(response => {
        console.log('stock holdings failed!', response);
      })
  }
}

export function setPortfolio(portfolio) {
  return { type: types.SET_PORTFOLIO, portfolio }
}

export function setStockHoldings(stockHoldings) {
  return { type: types.SET_STOCK_HOLDINGS, stockHoldings }
}

export function setCashHoldings(cashHoldings) {
  return { type: types.SET_CASH_HOLDINGS, cashHoldings }
}

export function receiveChannelData(data) {
  if (data.message) {
    return addMessage(data.message)
  } else if (data.stock_trade) {
    return addStockTrade(data.stock_trade)
  } else if (data.cash_trade) {
    return addCashTrade(data.cash_trade)
  }
}

export function addMessage(message) {
  return {
    type: types.ADD_MESSAGE,
    message,
  }
}

export function addStockTrade(trade) {
  return {
    type: types.ADD_STOCK_TRADE,
    trade,
  }
}

export function addCashTrade(trade) {
  return {
    type: types.ADD_CASH_TRADE,
    trade,
  }
}

export function toggleStockHoldingCollapsed(id) {
  return {
    type: types.TOGGLE_STOCK_HOLDING_COLLAPSED,
    id,
  }
}
