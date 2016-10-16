import React from 'react';
import { connect } from 'react-redux';
import {MessagesContainer} from './messages'
import {TradesContainer} from './Trades'
import {HoldingsContainer} from './holdings'
import {setPromoPortfolio} from '../actions.jsx'

export class Portfolio extends React.Component {
  componentDidMount = () => {
    this.props.setPromoPortfolio();
  }

  render = () => {
    return (
      <div className="container">
        <div className="row">
          <h3>Portfolio name: {this.props.name}</h3>
        </div>
        <div className="row">
          <div className="col-xs-12 col-sm-4">
            <HoldingsContainer />
          </div>
          <div className="col-xs-12 col-sm-4">
            <TradesContainer />
          </div>
          <div className="col-xs-12 col-sm-4">
            <MessagesContainer portfolioId={this.props.id} />
          </div>
        </div>
      </div>
    )
  };
}

function mapStateToProps(state) {
  return {
    name: state.getIn(['portfolio', 'name']),
    id: state.getIn(['portfolio', 'id'])
  }
}

export const PortfolioContainer = connect(
  mapStateToProps,
  { setPromoPortfolio }
)(Portfolio);
