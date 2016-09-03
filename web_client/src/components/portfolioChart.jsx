import React from 'react';
import { connect } from 'react-redux';
import { List, Map, fromJS, Seq } from 'immutable';
import uuid from 'uuid';
import _ from 'lodash';

import '../stylesheets/components/portfolio-chart.css'


export class PortfolioChart extends React.Component{
  state = {
    chartId: `chart-${uuid.v4()}`,
  };

  componentDidUpdate = () => {
    if (this.props.cashHoldings && this.props.stockHoldings && this.props.stockMinuteBars) {
      this._nvd3Chart(this.state.chartId, this.props.cashHoldings, this.props.stockHoldings, this.props.stockMinuteBars);
    }
  };

  render = () => {
    return (
      <div>
        <svg id={this.state.chartId}></svg>
      </div>
    )
  };

  _nvd3Chart = (chartId, cashHoldings, stockHoldings, stockMinuteBars) => {
    let current_time = Date.now();
    let start_time = Date.now() - 60000 * 60 * 24;
    let extra_seconds = start_time % 60000;
    start_time = start_time - extra_seconds;

    let portfolioData = [];
    let that = this;

    cashHoldings.forEach(function(holding) {
      let holdingData = that._holdingCashData(holding, _.cloneDeep(start_time), _.cloneDeep(current_time));
      portfolioData.push(holdingData)
    });

    stockHoldings.forEach(function(holding) {
        let minuteBars = that._findMinuteBar(holding, stockMinuteBars);

        let holdingData = that._holdingStockData(holding, minuteBars, _.cloneDeep(start_time), _.cloneDeep(current_time));
        portfolioData.push(holdingData)
    });

    var colors = d3.scale.category20();
    var chart;

    var expandLegend = function() {
      var exp = chart.legend.expanded();
      chart.legend.expanded(!exp);
      chart.update();
    };

    nv.addGraph(function() {
      chart = nv.models.stackedAreaChart()
                .useInteractiveGuideline(true)
                .x(function(d) { return d[0] })
                .y(function(d) { return d[1] })
                .controlLabels({stacked: "Stacked"})
                .duration(300);

      var x = d3.time.scale()
                .domain([(new Date() - 1000*60*24), new Date])
                .nice(d3.time.day)
                .range([0, 1200]);

      chart.xAxis.scale(x).ticks(24).tickFormat(function(d) { return d3.time.format('%H:%M')(new Date(d)) });

      chart.yAxis.tickFormat(d3.format(',.0f'));

      chart.legend.vers('furious');
      d3.select(`#${chartId}`)
        .datum(portfolioData)
        .style({ 'width': '800px', 'height': '500px' })
        .transition().duration(1000)
        .call(chart);

      nv.utils.windowResize(chart.update);
      return chart;
    });
  };

  _findMinuteBar = (holding, minuteBars) => {
    let foundBars;
    minuteBars.forEach(function(bars) {
      if (holding.getIn(['holding', 'stock_id']) == bars.getIn(['stock', 'id'])) {
        foundBars = bars
      }
    });
    return foundBars
  };

  _holdingCashData = (holding, start_time, current_time) => {
    let holdingData = {
      key: holding.getIn(['holding', 'currency']),
      values: [],
    };

    let trades = _.cloneDeep(holding.getIn(['trades']).toJS());
    let quantity = 0;
    let moving_date = new Date(trades[0].created_at).getTime();

    while (moving_date < start_time && trades.size > 0) {
      while (new Date(trades[0].created_at).getTime() < moving_date) {
        let trade = trades.shift();
        quantity = quantity + Number(trade.quantity);
        trades = trades;
      }
      moving_date = moving_date + 60000;
    }
    while (start_time < current_time) {
      while (trades.length > 0 && new Date(trades[0].created_at).getTime() < start_time) {
        let trade = trades.shift();
        quantity = quantity + Number(trade.quantity);
      }
      holdingData.values.push([start_time, quantity]);
      start_time = start_time + 60000
    };
    return holdingData;
  };

  _holdingStockData = (holding, minuteBars, start_time, current_time) => {
    let holdingData = {
      key: holding.getIn(['holding', 'name']),
      values: [],
    };

    let quotes = _.cloneDeep(minuteBars.getIn(['minute_bars']).toJS());
    let trades = _.cloneDeep(holding.getIn(['trades']).toJS());
    let quantity = 0;
    let moving_date = new Date(trades[0].created_at).getTime();

    let currentQuote = quotes.shift();
    while (moving_date < start_time && trades.length > 1) {
      while (new Date(currentQuote.quote_time).getTime() < moving_date) {
        if (quotes.length > 1) {
          currentQuote = quotes.shift();
        }
        break
      }

      while (new Date(trades[0].created_at).getTime() < moving_date) {
        let trade = trades.shift();
        quantity = quantity + Number(trade.quantity);
      }
      moving_date = moving_date + 60000;
    }

    while (start_time < current_time) {
      while (new Date(currentQuote.quote_time).getTime() < start_time) {
        if (quotes.length > 1) {
          currentQuote = quotes.shift();
        }
        break
      }

      while (trades.length > 0 && new Date(trades[0].created_at).getTime() < start_time) {
        let trade = trades.shift();
        quantity = quantity + Number(trade.quantity);
      }
      let currentValue =  Number(currentQuote.close);
      holdingData.values.push([start_time, (quantity * currentValue)]);
      start_time = start_time + 60000;
    };
    return holdingData;
  }
}

function mapStateToProps(state) {
  return {
    cashHoldings: state.getIn(['cashHoldings']),
    stockHoldings: state.getIn(['stockHoldings']),
    stockMinuteBars: state.getIn(['stockMinuteBars']),
  }
}

export const PortfolioChartContainer = connect(
  mapStateToProps
)(PortfolioChart);
