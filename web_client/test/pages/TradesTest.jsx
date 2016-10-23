import chai from 'chai';
import chaiEnzyme from 'chai-enzyme';
import React from 'react';
import { expect } from 'chai';
import { shallow } from 'enzyme';

import Trades from '../../src/pages/Trades';
import { FullNavbar } from '../../src/components/FullNavbar.jsx';

chai.use(chaiEnzyme());


describe('Trades', () => {
  it('should render props', () => {
    const wrapper = shallow(
      <Trades />
    );

    expect(wrapper.find(FullNavbar)).to.have.length(1);
  })
});
