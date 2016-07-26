import React from 'react';
import { connect } from 'react-redux';
import {Message} from './message'
import { List, Map, fromJS } from 'immutable';

export const Messages = React.createClass({
  render: function() {
    return (
      <div>
        <h1>Messages~</h1>
        {this._renderMessages(this.props.messages)}
      </div>
    )
  },

  _renderMessages(messages) {
    return messages.map(function(message, i) {
      return (<Message content={message.getIn(['content'])} key={i}/>)
    });
  }
});

function mapStateToProps(state) {
  return {
    messages: state.getIn(['messages']),
  }
}

export const MessagesContainer = connect(
  mapStateToProps
)(Messages);
