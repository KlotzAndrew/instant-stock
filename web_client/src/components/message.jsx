import React from 'react';

export const Message = React.createClass({
  render: function() {
    return (
      <p>message_content: {this.props.content}</p>
    )
  }
})
