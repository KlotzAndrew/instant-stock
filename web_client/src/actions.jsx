//import * as types from '../constants/ActionTypes'
export const SET_PORTFOLIO = 'SET_PORTFOLIO';
export const SET_PORTFOLIO_ASSOCIATIONS = 'SET_PORTFOLIO_ASSOCIATIONS';
export const SET_STOCK_HOLDINGS = 'SET_STOCK_HOLDINGS';
export const SET_CASH_HOLDINGS = 'SET_CASH_HOLDINGS';
import portfolioApi from './api/portfolio.jsx';
import stockHoldingsApi from './api/portfolioStockHoldings.jsx'
import cashHoldingsApi from './api/portfolioCashHoldings.jsx'

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
  return { type: SET_PORTFOLIO, portfolio }
}

export function setStockHoldings(stockHoldings) {
  return { type: SET_STOCK_HOLDINGS, stockHoldings }
}

export function setCashHoldings(cashHoldings) {
  return { type: SET_CASH_HOLDINGS, cashHoldings }
}
