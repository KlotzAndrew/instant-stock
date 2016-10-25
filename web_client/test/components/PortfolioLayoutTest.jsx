import chai from 'chai';
import chaiEnzyme from 'chai-enzyme';
import React from 'react';
import { expect } from 'chai';
import { shallow } from 'enzyme';

import { PortfolioLayout } from '../../src/components/PortfolioLayout.jsx';
import StockHoldings from '../../src/components/StockHoldings.jsx';
import StockHolding from '../../src/components/StockHolding.jsx';
import Trades from '../../src/components/Trades.jsx';
import Messages from '../../src/components/Messages.jsx';

chai.use(chaiEnzyme());


describe('PortfolioLayout', () => {
  it('should render components', () => {
    const name = 'test name';
    const id = 'id123';
    const expectedString = `Portfolio name: ${name}`;
    const wrapper = shallow(
        <PortfolioLayout name={name} id={id} />
    );

    expect(wrapper.find('.portfolio-name').text()).to.equal(expectedString);

    expect(wrapper.find(StockHoldings)).to.have.length(1);
    expect(wrapper.find(StockHoldings)).to.have.prop('holdingComponent', StockHolding);

    expect(wrapper.find(Trades)).to.have.length(1);

    expect(wrapper.find(Messages)).to.have.length(1);
    expect(wrapper.find(Messages)).to.have.prop('portfolioId', id);
  })
});
