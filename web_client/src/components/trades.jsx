import React from 'react';
import { connect } from 'react-redux';
import {Trade} from './Trade'
import { List, Map, fromJS } from 'immutable';

export class Trades extends React.Component {
  render = () => {
    return (
      <div>
        <h1>Trades~</h1>
        {this._renderTrades(this.props.trades)}
      </div>
    )
  };

  _renderTrades = (trades) => {
    return trades.map(function(trade, i) {
      return (
        <Trade
          enterPrice={trade.getIn(['attributes', 'enterPrice'])}
          quantity={trade.getIn(['attributes', 'quantity'])}
          stockName={trade.getIn(['attributes', 'stockName'])}
          key={i}
        />
      )
    });
  };
};

function mapStateToProps(state) {
  return {
    trades: state.getIn(['stockTrades']),
  }
}

export default connect(
  mapStateToProps
)(Trades);
