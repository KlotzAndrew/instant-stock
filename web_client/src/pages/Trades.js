import React, { Component } from 'react';
import { FullNavbar } from './../components/FullNavbar';
import TradesLayout from './../components/TradesLayout.jsx';


export default class TradesPage extends Component {
  render() {
    return (
      <div>
        <FullNavbar />
        <TradesLayout />
      </div>
    );
  }
}
