import React from 'react';
import { connect } from 'react-redux';
import {MessagesContainer} from './messages'
import {TradesContainer} from './trades'
import {HoldingsContainer} from './holdings'
import {PortfolioChartContainer} from './portfolioChart.jsx'

export const Portfolio = React.createClass({
  render: function() {
    return (
      <div className="container">
        <div className="row">
          <div className="col-xs-12 col-sm-6">
            <h3>Portfolio name: {this.props.name}</h3>
            <PortfolioChartContainer />
            <h3>Portfolio value: {this.props.value}</h3>
            <TradesContainer />
            <HoldingsContainer />
          </div>
          <div className="col-xs-12 col-sm-6">
            <MessagesContainer portfolioId={this.props.id} />
          </div>
        </div>
      </div>
    )
  }
})

function mapStateToProps(state) {
  return {
    name: state.getIn(['portfolio', 'name']),
    id: state.getIn(['portfolio', 'id']),
    value: state.getIn(['value'])
  }
}

export const PortfolioContainer = connect(
  mapStateToProps
)(Portfolio);
