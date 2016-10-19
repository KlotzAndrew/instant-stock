import React from 'react';
import { expect } from 'chai';
import { shallow } from 'enzyme';

import { StockHolding } from '../../src/components/StockHolding.jsx'


describe('StockHolding', function cashHolding() {
  it('should render', function renderProps() {
    const current_total = '123.01';
    const name = 'test name';

    const expectedString = 'test name | current_total: 123.01';

    const wrapper = shallow(
      <StockHolding
        current_total={current_total}
        name={name}
      />
    );

    expect(wrapper.text()).to.equal(expectedString)
  })
});
