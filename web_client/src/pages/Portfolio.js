import React, { Component } from 'react';
import PortfolioLayout from './../components/PortfolioLayout';
import { connect } from 'react-redux';
import { FullNavbar } from './../components/FullNavbar'


export class Portfolio extends React.Component {
  render = () => {
    return (
      <div>
        <FullNavbar />
        <PortfolioLayout />
      </div>
    );
  };
}

function mapStateToProps(state) {
  return {}
}

export default connect(
  mapStateToProps
)(Portfolio);

