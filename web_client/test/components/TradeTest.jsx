import React from 'react';
import { expect } from 'chai';
import { shallow } from 'enzyme';
import { fromJS } from 'immutable';

import { Trade } from '../../src/components/Trade.jsx';


describe('Trade', function trade() {
  it('should render props', () => {
    const enterPrice = '123';
    const quantity = '99';
    const stockName = 'test name';
    const trade = fromJS({
      attributes: {
        stockName: stockName,
        enter_price: enterPrice,
        quantity: quantity,
        createdAt: '2016-10-25T00:28:42.728Z'
      }
    });

    const expectedString = 'test name |2016/10/24 20:28:42 | enter_price:  | quantity: 99';

    const wrapper = shallow(
      <Trade
        trade={trade}
      />
    );

    expect(wrapper.text()).to.equal(expectedString);
  });

  it('should render loading without trade', () => {
    const expectedString = 'loading...';
    const wrapper = shallow(
      <Trade />
    );

    expect(wrapper.text()).to.equal(expectedString);
  });
});
