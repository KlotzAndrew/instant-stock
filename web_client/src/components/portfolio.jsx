import React from 'react';
import { connect } from 'react-redux';

export const Portfolio = React.createClass({
  render: function() {
    return (
      <div>
        <h1>Portfolio~</h1>
        <h3>Portfolio name: {this.props.name}</h3>
        <h3>Portfolio value: {this.props.value}</h3>
      </div>
    )
  }
})

function mapStateToProps(state) {
  return {
    name: state.getIn(['portfolio', 'name']),
    value: state.getIn(['value']),
  }
}

export const PortfolioContainer = connect(
  mapStateToProps
)(Portfolio);
