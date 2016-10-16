import React from 'react';
import { expect } from 'chai';
import { shallow } from 'enzyme';

import { Trade } from '../../src/components/Trade.jsx'


describe('Trade', function trade() {
  it('should render props', function renderProps() {
    const enterPrice = '123';
    const quantity = '99';
    const stockName = 'test name';

    const expectedString = 'test name | enter_price: 123 | quantity: 99';

    const wrapper = shallow(
      <Trade
        enterPrice={enterPrice}
        quantity={quantity}
        stockName={stockName}
      />
    );

    expect(wrapper.text()).to.equal(expectedString)
  })
});
