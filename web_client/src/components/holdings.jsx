import React from 'react';
import { connect } from 'react-redux';
import {CashHolding} from './cashHolding'
import {StockHolding} from './stockHolding'
import { List, Map, fromJS } from 'immutable';

export class Holdings extends React.Component {
  render = () => {
    return (
      <div>
        <h4>CashHoldings~</h4>
        {this._renderCashHoldings(this.props.portfolio, this.props.cashHoldings)}
        <h4>StockHoldings~</h4>
        {this._renderStockHoldings(this.props.portfolio, this.props.stockHoldings, this.props.stocks)}
      </div>
    )
  };

  _renderCashHoldings = (portfolio, holdings) => {
    return portfolio.getIn(['cashHoldings']).map((portfolioHolding, index) => {
      const id = portfolioHolding.getIn(['id']);
      const holding = holdings.getIn([id]);
      if (holding) {
        return (
          <CashHolding
            currency={holding.getIn(['currency'])}
            current_total={holding.getIn(['currentTotal'])}
            key={id}
          />
        )
      }
    });
  };

  _renderStockHoldings = (portfolio, holdings, stocks) => {
    return portfolio.getIn(['stockHoldings']).map((portfolioHolding, index) => {
      const id = portfolioHolding.getIn(['id']);
      const holding = holdings.getIn([id]);
      if (holding) {
        const stock = this.holdingStock(holding, stocks);
        return (
          <StockHolding
            name={stock.getIn(['name'])}
            current_total={holding.getIn(['currentTotal'])}
            key={index}
          />
        )
      }
    });
  };

  holdingStock = (holding, stocks) => {
    const stockId = holding.getIn(['stockId'])
    return stocks.getIn([stockId])
  }
};

function mapStateToProps(state) {
  return {
    portfolio: state.getIn(['portfolio']),
    stocks: state.getIn(['stocks']),
    cashHoldings: state.getIn(['cashHoldings']),
    stockHoldings: state.getIn(['stockHoldings'])
  }
}

export const HoldingsContainer = connect(
  mapStateToProps
)(Holdings);
