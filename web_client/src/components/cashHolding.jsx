import React from 'react';

export const CashHolding = React.createClass({
  render: function() {
    return (
      <p>
        current_total: {this.props.current_total} |
        currency: {this.props.currency}
      </p>
    )
  }
})
