import React from 'react';
import { connect } from 'react-redux';
import Messages from './Messages';
import Trades from './Trades';
import StockHoldings from './StockHoldings';
import StockHolding from './StockHolding.jsx';
import CashHoldings from './CashHoldings.jsx';
import { setPromoPortfolio } from '../actions.jsx';


export class PortfolioLayout extends React.Component {
  componentDidMount = () => {
    this.props.setPromoPortfolio();
  };

  render = () => {
    return (
      <div className="container">
        <div className="row">
          <h3 className="portfolio-name">Portfolio name: {this.props.name}</h3>
        </div>
        <div className="row">
          <div className="col-xs-12 col-sm-4">
            <StockHoldings holdingComponent={StockHolding} />
            <CashHoldings />
          </div>
          <div className="col-xs-12 col-sm-4">
            <Trades />
          </div>
          <div className="col-xs-12 col-sm-4">
            <Messages portfolioId={this.props.id} />
          </div>
        </div>
      </div>
    )
  };
}

function mapStateToProps(state) {
  return {
    name: state.getIn(['portfolio', 'attributes', 'name']),
    id: state.getIn(['portfolio', 'id'])
  }
}

export default connect(
  mapStateToProps,
  { setPromoPortfolio }
)(PortfolioLayout);
