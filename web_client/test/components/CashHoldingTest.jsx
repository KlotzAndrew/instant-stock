import React from 'react';
import { expect } from 'chai';
import { shallow } from 'enzyme';

import { CashHolding } from '../../src/components/CashHolding.jsx'


describe('CashHolding', function cashHolding() {
  it('should render props', function renderProps() {
    const currentTotal = '123.01';
    const currency = 'GBP';

    const expectedString = 'currentTotal: 123.01 | currency: GBP';

    const wrapper = shallow(
      <CashHolding
        currentTotal={currentTotal}
        currency={currency}
      />
    );

    expect(wrapper.text()).to.equal(expectedString)
  })
});
