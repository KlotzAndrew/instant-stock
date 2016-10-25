import React from 'react';
import { expect } from 'chai';
import { shallow } from 'enzyme';
import { fromJS } from 'immutable';

import { StockHolding } from '../../src/components/StockHolding.jsx'


describe('StockHolding', function cashHolding() {
  it('should render', function renderProps() {
    const lastQuote = '10.01';
    const currentTotal = 10;
    const stockName = 'test name';
    const stockHolding = fromJS({
      attributes: {
        currentTotal: currentTotal,
        stockName: stockName,
        lastQuote: lastQuote
      }
    });

    const expectedString = 'test name | total: 10 | $100.10';

    const wrapper = shallow(
      <StockHolding
        stockHolding={stockHolding}
      />
    );

    expect(wrapper.text()).to.equal(expectedString)
  })
});
