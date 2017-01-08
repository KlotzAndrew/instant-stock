import React from 'react';
import { connect } from 'react-redux';
import { toggleStockHoldingCollapsed } from '../actions.jsx'
import Trade from './Trade.jsx'


export class StockHoldingTrades extends React.Component {
  render = () => {
    const stockHolding = this.props.stockHolding;
    const value = this._stockValue(stockHolding);
    const collapsedStatus = stockHolding.getIn(['collapsedStatus']);
    const stockTrades = this._renderStockTrades(collapsedStatus, stockHolding);

    return (
      <div>
        <p onClick={this._handleClick}>
          {stockHolding.getIn(['attributes', 'stock-name'])} |
          total: {stockHolding.getIn(['attributes', 'current-total'])} |
          ${(value).toFixed(2)}
        </p>
        {stockTrades}
      </div>
    );
  };

  _handleClick = () => {
    this.props.toggleStockHoldingCollapsed(this.props.id);
  };

  _renderStockTrades = (collapsedStatus, stockHolding) => {
    if (collapsedStatus === true) {
      return this._listStockTrades(
        stockHolding.getIn(['relationships', 'stock-trades', 'data'])
      )
    }
  };

  _listStockTrades = (trades) => {
    return trades.map(function(trade, i) {
      return (
        <Trade
          id={trade.getIn(['id'])}
          key={i}
        />
      )
    })
  };

  _stockValue = (stockHolding) => {
    const total = stockHolding.getIn(['attributes', 'current-total']);
    const quote = stockHolding.getIn(['attributes', 'last-quote']);
    return total*quote
  }
}

function mapStateToProps(state, ownProps) {
  return {
    stockHolding: state.getIn(['stockHoldings', ownProps.id])
  }
}

export default connect(
  mapStateToProps,
  { toggleStockHoldingCollapsed }
)(StockHoldingTrades);
