import React from 'react';

export const StockHolding = ({name, current_total}) => (
  <p>{name} | current_total: {current_total}</p>
);
