import React from 'react';

export const StockHolding = ({name, currentTotal, lastQuote}) => (
  <p>{name} | total: {currentTotal} | ${(currentTotal*lastQuote).toFixed(2)}</p>
);
