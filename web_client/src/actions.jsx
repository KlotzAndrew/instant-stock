//import * as types from '../constants/ActionTypes'
export const SET_PORTFOLIO = 'SET_PORTFOLIO';
export const SET_PORTFOLIO_ASSOCIATIONS = 'SET_PORTFOLIO_ASSOCIATIONS';
export const SET_STOCK_HOLDINGS = 'SET_STOCK_HOLDINGS';
import portfolioApi from './api/portfolio.jsx';
import stockHoldingsApi from './api/portfolioStockHoldings.jsx'

export function setPromoPortfolio() {
  return dispatch => {
    portfolioApi.getPromoPortfolio()
      .then(response => {
        dispatch(setPortfolio(response.data.data));
        dispatch(setPortfolioStockHoldings(response.data.data.id))
      })
      .catch(response => {
        console.log('it failed!', response)
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
  return { type: SET_PORTFOLIO, portfolio}
}

export function setStockHoldings(stockHoldings) {
  return { type: SET_STOCK_HOLDINGS, stockHoldings}
}
