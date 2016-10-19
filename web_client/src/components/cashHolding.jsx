import React from 'react';

export const CashHolding = ({currency, current_total}) => (
  <p>
    current_total: {current_total} |
    currency: {currency}
  </p>
);
