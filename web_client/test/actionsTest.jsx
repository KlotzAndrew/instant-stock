import { expect } from 'chai';

import * as types from '../src/actionTypes'
import * as actions from '../src/actions.jsx'


describe('actions', () => {
  it('addMessage', () => {
    const message = {id: 123};
    const expectedAction = {
      type: types.ADD_MESSAGE,
      message
    };

    expect(actions.addMessage(message)).to.deep.equal(expectedAction)
  });

  it('addStockTrade', () => {
    const trade = {id: 123};
    const expectedAction = {
      type: types.ADD_STOCK_TRADE,
      trade
    };

    expect(actions.addStockTrade(trade)).to.deep.equal(expectedAction)
  });

  it('addCashTrade', () => {
    const trade = {id: 123};
    const expectedAction = {
      type: types.ADD_CASH_TRADE,
      trade
    };

    expect(actions.addCashTrade(trade)).to.deep.equal(expectedAction)
  });

  it('setPortfolio', () => {
    const portfolio = {id: 123};
    const expectedAction = {
      type: types.SET_PORTFOLIO,
      portfolio
    };

    expect(actions.setPortfolio(portfolio)).to.deep.equal(expectedAction)
  });

  it('setStockHoldings', () => {
    const stockHoldings = [{id: 123}, {id:234}];
    const expectedAction = {
      type: types.SET_STOCK_HOLDINGS,
      stockHoldings
    };

    expect(actions.setStockHoldings(stockHoldings)).to.deep.equal(expectedAction)
  });

  it('setCashHoldings', () => {
    const cashHoldings = [{id: 123}, {id:234}];
    const expectedAction = {
      type: types.SET_CASH_HOLDINGS,
      cashHoldings
    };

    expect(actions.setCashHoldings(cashHoldings)).to.deep.equal(expectedAction)
  });
});
