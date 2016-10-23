import chai from 'chai';
import chaiEnzyme from 'chai-enzyme';
import React from 'react';
import { expect } from 'chai';
import { shallow } from 'enzyme';

import { Portfolio } from '../../src/pages/Portfolio';
import { FullNavbar } from '../../src/components/FullNavbar.jsx';
import PortfolioLayout from '../../src/components/PortfolioLayout.jsx';

chai.use(chaiEnzyme());


describe('Portfolio', () => {
  it('should render props', () => {
    const wrapper = shallow(
      <Portfolio />
    );

    expect(wrapper.find(FullNavbar)).to.have.length(1);
    expect(wrapper.find(PortfolioLayout)).to.have.length(1);
  })
});
