import React from 'react';

export const StockHolding = React.createClass({
  render: function() {
    return (
      <p>
        {this.props.name} |
        current_total: {this.props.current_total}
      </p>
    )
  }
})
