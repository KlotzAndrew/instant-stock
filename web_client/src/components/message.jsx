import React from 'react';

export const Message = React.createClass({
  render: function() {
    return (
      <p>anon: {this.props.content}</p>
    )
  }
});
