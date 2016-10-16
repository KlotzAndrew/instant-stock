import React from 'react';
import { expect } from 'chai';
import { shallow } from 'enzyme';

import { Message } from '../../src/components/Message.jsx'


describe('Message', function message() {
  it('should render props', function renderProps() {
    const content = 'some message';

    const expectedString = 'anon: some message';

    const wrapper = shallow(
      <Message
        content={content}
      />
    );

    expect(wrapper.text()).to.equal(expectedString)
  })
});
