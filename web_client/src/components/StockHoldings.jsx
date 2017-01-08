import React from 'react';
import { connect } from 'react-redux';
import { StockHolding } from './StockHolding';
import { List, Map, fromJS } from 'immutable';

export class StockHoldings extends React.Component {
  render = () => {
    return (
      <div>
        <h4>StockHoldings~</h4>
        {this._renderStockHoldings(this.props.portfolio, this.props.stockHoldings)}
      </div>
    )
  };

  _renderStockHoldings = (portfolio, holdings) => {
    const holdingRelationships = portfolio.getIn(['relationships', 'stock-holdings', 'data']);
    if (holdingRelationships) {
      return holdingRelationships.map((portfolioHolding, index) => {
        const id = portfolioHolding.getIn(['id']);
        const holding = holdings.getIn([id]);
        if (holding) {
          return (
            <this.props.holdingComponent
              id={holding.getIn(['id'])}
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
    stockHoldings: state.getIn(['stockHoldings'])
  }
}

export default connect(
  mapStateToProps
)(StockHoldings);
