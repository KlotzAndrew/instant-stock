import React from 'react';
import { connect } from 'react-redux';

export class StockHolding extends React.Component {
  render = () => {
    const stockHolding = this.props.stockHolding;
    const value = this._stockValue(stockHolding);
    return (
      <p>
        {stockHolding.getIn(['attributes', 'stockName'])} |
        total: {stockHolding.getIn(['attributes', 'currentTotal'])} |
        ${(value).toFixed(2)}
      </p>
    )
  };

  _stockValue = (stockHolding) => {
    const total = stockHolding.getIn(['attributes', 'currentTotal']);
    const quote = stockHolding.getIn(['attributes', 'lastQuote']);
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
