import chai from 'chai';
import chaiEnzyme from 'chai-enzyme';
import React from 'react';
import { expect } from 'chai';
import { shallow } from 'enzyme';
import { Provider } from 'react-redux';
import { fromJS } from 'immutable';

import { Messages } from '../../src/components/Messages.jsx';
import { Message } from '../../src/components/Message.jsx';

chai.use(chaiEnzyme());


describe('Messages', function portfolio() {
  it('should render message', function renderProps() {
    const portfolioMessages = fromJS([{id: '123'}]);
    const content = 'some content';
    const messages = fromJS({
      123: {content: content}
    });
    const wrapper = shallow(
      <Messages portfolioMessages={portfolioMessages} messages={messages} />
    );

    expect(wrapper.find(Message)).to.have.length(1);
    expect(wrapper.find(Message)).to.have.prop('content', content)
  })
});
