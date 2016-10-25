import React from 'react';
import { connect } from 'react-redux';
import moment from 'moment';

export class Trade extends React.Component {
  render = () => {
    const trade = this._renderTrade(this.props.trade);

    return (
      <div>{trade}</div>
    )
  };

  _renderTrade = (trade) => {
    if (trade) {
      return this._tradeDetails(trade);
    }
    return this._tradeLoading()
  };

  _tradeDetails = (trade) => {
    return (
      <p>
        {trade.getIn(['attributes', 'stockName'])} |
        {moment(trade.getIn(['attributes', 'createdAt'])).format('YYYY/MM/DD HH:mm:s')} |
        enter_price: {trade.getIn(['attributes', 'enterPrice'])} |
        quantity: {trade.getIn(['attributes', 'quantity'])}
      </p>
    )
  };

  _tradeLoading = () => {
    return (
      <p>loading...</p>
    )
  };
}

function mapStateToProps(state, ownProps) {
  return {
    trade: state.getIn(['stockTrades', ownProps.id]),
  };
}

export default connect(
  mapStateToProps
)(Trade);

