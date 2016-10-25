import React from 'react';
import { connect } from 'react-redux';
import Trade from './Trade'
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
    return trades.map((trade, index) => {
      return (
        <Trade
          id={trade.getIn(['id'])}
          key={index}
        />
      )
    });
  };
}

function mapStateToProps(state) {
  return {
    trades: state.getIn(['stockTrades']),
  }
}

export default connect(
  mapStateToProps
)(Trades);
