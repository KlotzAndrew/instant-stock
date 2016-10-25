import React from 'react';
import { connect } from 'react-redux';
import StockHoldingTrades from './StockHoldingTrades.jsx';
import { setPromoPortfolio } from '../actions.jsx';
import StockHoldings from './StockHoldings.jsx';


export class TradesLayout extends React.Component {
  componentDidMount = () => {
    this.props.setPromoPortfolio();
  };

  render = () => {
    return (
      <div className="container">
        <div className="row">
          <h3 className="">Trades</h3>
        </div>
        <div className="row">
          <div className="col-xs-12 col-sm-12">
            <StockHoldings
              holdingComponent={StockHoldingTrades}
            />
          </div>
        </div>
      </div>
    )
  };
}

function mapStateToProps(state) {
  return {}
}

export default connect(
  mapStateToProps,
  { setPromoPortfolio }
)(TradesLayout);
