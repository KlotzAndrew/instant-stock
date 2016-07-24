import React from 'react';
import { connect } from 'react-redux';

export const Portfolio = React.createClass({
  render: function() {
    return (
      <div>
        <h1>Portfolio~</h1>
        <h3>Portfolio name: {this.props.name}</h3>
        <h3>Portfolio cash: {this.props.cash}</h3>
      </div>
    )
  }
})

function mapStateToProps(state) {
  return {
    name: state.getIn(['portfolio', 'name']),
    cash: state.getIn(['portfolio', 'cash']),
  }
}

export const PortfolioContainer = connect(
  mapStateToProps
)(Portfolio);
