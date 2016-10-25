import chai from 'chai';
import chaiEnzyme from 'chai-enzyme';
import React from 'react';
import { expect } from 'chai';
import { shallow } from 'enzyme';

import { TradesLayout } from '../../src/components/TradesLayout.jsx';
import StockHoldings from '../../src/components/StockHoldings.jsx';
import StockHoldingTrades from '../../src/components/StockHoldingTrades.jsx';

chai.use(chaiEnzyme());


describe('TradesLayout', () => {
  it('should render components', () => {
    const name = 'test name';
    const id = 'id123';
    const expectedString = `Portfolio name: ${name}`;
    const wrapper = shallow(
      <TradesLayout />
    );

    expect(wrapper.find(StockHoldings)).to.have.length(1);
    expect(wrapper.find(StockHoldings)).to.have.prop('holdingComponent', StockHoldingTrades);
  })
});
