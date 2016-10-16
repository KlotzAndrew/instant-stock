import React from 'react';
import { connect } from 'react-redux';
import { CashHolding } from './cashHolding'
import { StockHolding } from './StockHolding'
import { List, Map, fromJS } from 'immutable';

export class Holdings extends React.Component {
  render = () => {
    return (
      <div>
        <h4>CashHoldings~</h4>
        {this._renderCashHoldings(this.props.portfolio, this.props.cashHoldings)}
        <h4>StockHoldings~</h4>
        {this._renderStockHoldings(this.props.portfolio, this.props.stockHoldings)}
      </div>
    )
  };

  _renderCashHoldings = (portfolio, holdings) => {
    //return portfolio.getIn(['cashHoldings']).map((portfolioHolding, index) => {
    //  const id = portfolioHolding.getIn(['id']);
    //  const holding = holdings.getIn([id]);
    //  if (holding) {
    //    return (
    //      <CashHolding
    //        currency={holding.getIn(['currency'])}
    //        current_total={holding.getIn(['currentTotal'])}
    //        key={id}
    //      />
    //    )
    //  }
    //});
  };

  _renderStockHoldings = (portfolio, holdings) => {
    const holdingRelationships = portfolio.getIn(["relationships", "stockHoldings", "data"])
    if (holdingRelationships) {
      return holdingRelationships.map((portfolioHolding, index) => {
        const id = portfolioHolding.getIn(['id']);
        const holding = holdings.getIn([id]);
        if (holding) {
          return (
            <StockHolding
              name={holding.getIn(['attributes', 'stockName'])}
              current_total={holding.getIn(['attributes', 'currentTotal'])}
              key={index}
            />
          )
        }
      });
    }
  };
};

function mapStateToProps(state) {
  return {
    portfolio: state.getIn(['portfolio']),
    cashHoldings: state.getIn(['cashHoldings']),
    stockHoldings: state.getIn(['stockHoldings'])
  }
}

export const HoldingsContainer = connect(
  mapStateToProps
)(Holdings);
