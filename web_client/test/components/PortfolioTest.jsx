import chai from 'chai';
import chaiEnzyme from 'chai-enzyme';
import React from 'react';
import { expect } from 'chai';
import { shallow } from 'enzyme';
import { Provider } from 'react-redux';

import { Portfolio } from '../../src/components/Portfolio.jsx';
import Holdings from '../../src/components/Holdings.jsx';
import Trades from '../../src/components/Trades.jsx';
import Messages from '../../src/components/Messages.jsx';

chai.use(chaiEnzyme());


describe('Portfolio', function portfolio() {
  it('should render props', function renderProps() {
    const name = 'test name';
    const id = 'id123';
    const expectedString = `Portfolio name: ${name}`;
    const wrapper = shallow(
        <Portfolio name={name} id={id} />
    );

    expect(wrapper.find('.portfolio-name').text()).to.equal(expectedString);
    expect(wrapper.find(Holdings)).to.have.length(1);
    expect(wrapper.find(Trades)).to.have.length(1);
    expect(wrapper.find(Messages)).to.have.length(1);
    expect(wrapper.find(Messages)).to.have.prop('portfolioId', id)
  })
});
