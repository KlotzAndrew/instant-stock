import React from 'react';
import { connect } from 'react-redux';
import { CashHolding } from './CashHolding';
import { List, Map, fromJS } from 'immutable';

export class CashHoldings extends React.Component {
  render = () => {
    return (
      <div>
        <h4>CashHoldings~</h4>
        {this._renderCashHoldings(this.props.portfolio, this.props.cashHoldings)}
      </div>
    )
  };

  _renderCashHoldings = (portfolio, holdings) => {
    const holdingRelationships = portfolio.getIn(['relationships', 'cash-holdings', 'data']);
    if (holdingRelationships) {
      return holdingRelationships.map((portfolioHolding, index) => {
        const id = portfolioHolding.getIn(['id']);
        const holding = holdings.getIn([id]);
        if (holding) {
          return (
            <CashHolding
              currency={holding.getIn(['attributes', 'currency'])}
              currentTotal={holding.getIn(['attributes', 'current-total'])}
              key={index}
            />
          )
        }
      });
    }
  };
};

function mapStateToProps(state) {
  return {
    portfolio: state.getIn(['portfolio']),
    cashHoldings: state.getIn(['cashHoldings'])
  }
}

export default connect(
  mapStateToProps
)(CashHoldings);
