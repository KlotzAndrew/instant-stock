import React from 'react';
import { connect } from 'react-redux';

export class StockHolding extends React.Component {
  render = () => {
    const stockHolding = this.props.stockHolding;
    const value = this._stockValue(stockHolding);
    return (
      <p>
        {stockHolding.getIn(['attributes', 'stock-name'])} |
        total: {stockHolding.getIn(['attributes', 'current-total'])} |
        ${(value).toFixed(2)}
      </p>
    )
  };

  _stockValue = (stockHolding) => {
    const total = stockHolding.getIn(['attributes', 'current-total']);
    const quote = stockHolding.getIn(['attributes', 'last-quote']);
    return total*quote;
  };
}

function mapStateToProps(state, ownProps) {
  return {
    stockHolding: state.getIn(['stockHoldings', ownProps.id])
  }
}

export default connect(
  mapStateToProps
)(StockHolding);
