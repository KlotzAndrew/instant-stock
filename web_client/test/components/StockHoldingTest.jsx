import React from 'react';
import { expect } from 'chai';
import { shallow } from 'enzyme';

import { StockHolding } from '../../src/components/StockHolding.jsx'


describe('StockHolding', function cashHolding() {
  it('should render', function renderProps() {
    const lastQuote = '10.01';
    const currentTotal = '10';
    const name = 'test name';

    const expectedString = 'test name | total: 10 | $1001.00';

    const wrapper = shallow(
      <StockHolding
        lastQuote={currentTotal*lastQuote}
        currentTotal={currentTotal}
        name={name}
      />
    );

    expect(wrapper.text()).to.equal(expectedString)
  })
});
