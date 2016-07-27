import React from 'react';
import { connect } from 'react-redux';
import axiosInstance from '../config/axios';
import {Message} from './message'
import { List, Map, fromJS } from 'immutable';

export const Messages = React.createClass({
  getInitialState: function() {
    return {value: 'Hello!'};
  },
  handleChange: function(event) {
    this.setState({value: event.target.value});
  },
  _handleKeyPress: function(e) {
    if (e.key === 'Enter') {
      this._submitMessage(this.state.value, '4fa6de17-52be-4708-bd9e-95a7b4ec6555')
      this.state.value = '';
    }
  },

  render: function() {
    return (
      <div>
        <h1>Messages~</h1>
        {this._renderMessages(this.props.messages)}
        <input
          type="text"
          value={this.state.value}
          onChange={this.handleChange}
          onKeyPress={this._handleKeyPress}
        />
      </div>
    )
  },

  _renderMessages(messages) {
    return messages.map(function(message, i) {
      return (<Message content={message.getIn(['content'])} key={i}/>)
    });
  },

  _submitMessage(message, portfolioId) {
    return axiosInstance.post(`/portfolios/${portfolioId}/messages`, {content: message});
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
