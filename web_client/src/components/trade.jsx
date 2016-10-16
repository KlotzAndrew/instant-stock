import React from 'react';

export const Trade = React.createClass({
  render: function() {
    return (
      <p>
        {this.props.stockName} |
        enter_price: {this.props.enterPrice} |
        quantity: {this.props.quantity}
      </p>
    )
  }
})
