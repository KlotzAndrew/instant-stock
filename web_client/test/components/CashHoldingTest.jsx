import React from 'react';
import { expect } from 'chai';
import { shallow } from 'enzyme';

import { CashHolding } from '../../src/components/CashHolding.jsx'


describe('CashHolding', function cashHolding() {
  it('should render props', function renderProps() {
    const current_total = '123.01';
    const currency = 'GBP';

    const expectedString = 'current_total: 123.01 | currency: GBP';

    const wrapper = shallow(
      <CashHolding
        current_total={current_total}
        currency={currency}
      />
    );

    expect(wrapper.text()).to.equal(expectedString)
  })
});
