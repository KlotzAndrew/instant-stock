//import * as types from '../constants/ActionTypes'
export const SET_PORTFOLIO = 'SET_PORTFOLIO';
export const SET_PORTFOLIO_ASSOCIATIONS = 'SET_PORTFOLIO_ASSOCIATIONS';
import portfolioApi from './api/portfolio.jsx';

export function setPromoPortfolio() {
  return dispatch => {
    portfolioApi.getPromoPortfolio()
    .then(response => {
      dispatch(setPortfolio(response.data.data))
      dispatch(setPortfolioAssociations(response.data.included))
    })
    .catch(response => {
      console.log('it failed!', response)
    })
  }
}

export function setPortfolio(portfolio) {
  return { type: SET_PORTFOLIO, portfolio}
}

export function setPortfolioAssociations(included) {
  return { type: SET_PORTFOLIO_ASSOCIATIONS, included}
}
