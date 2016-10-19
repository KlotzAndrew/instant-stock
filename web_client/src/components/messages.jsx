import React from 'react';
import { connect } from 'react-redux';
import axiosInstance from '../config/axios';
import { Message } from './Message'
import { List, Map, fromJS } from 'immutable';

export class Messages extends React.Component {
  state = {
      value: '',
  };

  handleChange = (event) => {
    this.setState({value: event.target.value});
  };
  _handleKeyPress = (e) => {
    if (e.key === 'Enter') {
      this._submitMessage(this.state.value, this.props.portfolioId);
      this.state.value = '';
    }
  };

  render = () => {
    return (
      <div>
        <h1>Messages~</h1>
        {this._renderMessages(this.props.portfolioMessages, this.props.messages)}
        <input
          type="text"
          value={this.state.value}
          onChange={this.handleChange}
          onKeyPress={this._handleKeyPress}
          placeholder="Message"
        />
      </div>
    )
  };

  _renderMessages = (portMessages, messages) => {
    if (portMessages) {
      return portMessages.map(function(portMessage, i) {
      const messageId = portMessage.getIn(['id']);
      const message = messages.getIn([messageId]);
        if (message) {
          return (<Message content={message.getIn(['content'])} key={i}/>)
        }
      });
    }
  };

  _submitMessage = (message, portfolioId) => {
    return axiosInstance.post(`/portfolios/${portfolioId}/messages`, {content: message});
  };
}


function mapStateToProps(state) {
  return {
    portfolioMessages: state.getIn(['portfolio', 'relationships', 'messages', 'data']),
    messages: state.getIn(['messages'])
  }
}

export default connect(
  mapStateToProps
)(Messages);
