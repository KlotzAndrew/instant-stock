import React from 'react';
import { connect } from 'react-redux';
import {Trade} from './trade'
import { List, Map, fromJS } from 'immutable';

export const Trades = React.createClass({
  render: function() {
    return (
      <div>
        <h1>Trades~</h1>
        {this._renderTrades(this.props.trades)}
      </div>
    )
  },

  _renderTrades(trades) {
    return trades.map(function(trade, i) {
      return (
        <Trade
          enter_price={trade.getIn(['enter_price'])}
          quantity={trade.getIn(['quantity'])}
          stock_name={trade.getIn(['stock_name'])}
          key={i}
        />
      )
    });
  },
});

function mapStateToProps(state) {
  return {
    trades: state.getIn(['trades']),
  }
}

export const TradesContainer = connect(
  mapStateToProps
)(Trades);
