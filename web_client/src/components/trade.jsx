import React from 'react';

export const Trade = React.createClass({
  render: function() {
  console.log('this props', this.props)
    return (
      <p>
        stock_name: {this.props.stock_name} |
        enter_price: {this.props.enter_price} |
        quantity: {this.props.quantity}
      </p>
    )
  }
})
