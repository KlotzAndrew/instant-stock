import React from 'react';
import { connect } from 'react-redux';
import {CashHolding} from './cashHolding'
import {StockHolding} from './stockHolding'
import { List, Map, fromJS } from 'immutable';

export const Holdings = React.createClass({
  render: function() {
    return (
      <div>
        <h4>CashHoldings~</h4>
        {this._renderCashHoldings(this.props.cashHoldings)}
        <h4>StockHoldings~</h4>
        {this._renderStockHoldings(this.props.stockHoldings)}
      </div>
    )
  },

  _renderCashHoldings(holdings) {
    return holdings.map(function(holding, i) {
      return (
        <CashHolding
          currency={holding.getIn(['currency'])}
          current_total={holding.getIn(['current_total'])}
          key={i}
        />
      )
    });
  },

  _renderStockHoldings(holdings) {
    return holdings.map(function(holding, i) {
      return (
        <StockHolding
          name={holding.getIn(['name'])}
          current_total={holding.getIn(['current_total'])}
          key={i}
        />
      )
    });
  },
});

function mapStateToProps(state) {
  return {
    cashHoldings: state.getIn(['cashHoldings']),
    stockHoldings: state.getIn(['stockHoldings'])
  }
}

export const HoldingsContainer = connect(
  mapStateToProps
)(Holdings);
