import React from 'react';
import { connect } from 'react-redux';
import { List, Map, fromJS, Seq } from 'immutable';
import uuid from 'uuid';
import _ from 'lodash';

import '../stylesheets/components/portfolio-chart.css'


export const PortfolioChart = React.createClass({
  getInitialState: function() {
    return {chartId: `chart-${uuid.v4()}`};
  },

  componentDidUpdate: function() {
    if (this.props.portfolioMinutes) {
      this._nvd3Chart(this.props.portfolioMinutes);
    }
  },

  render: function() {
    return (
      <div>
        <svg id="chart1"></svg>
      </div>
    )
  },

  _nvd3Chart: function(portfolioMinutes) {
    let portfolioData = portfolioMinutes.toJS().map(function(k) {
      return [new Date(k[0]).getTime(), Number(k[1])]
    });
    portfolioData.pop(); // TODO: extra tailing 0 value being added from server

    const minY = _.minBy(portfolioData, function(a) {return a[1]})[1];
    const maxY = _.maxBy(portfolioData, function(a) {return a[1]})[1];

    var histcatexplong = function(portfolioData) {
      return [
        {
          "key": "Portfolio Value",
          "values": portfolioData
        },
      ];
    };
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
      chart.xAxis.tickFormat(function(d) { return d3.time.format('%x')(new Date(d)) });

      chart.yAxis.tickFormat(d3.format(',.0f'));

      chart.legend.vers('furious');
      d3.select('#chart1')
        .datum(histcatexplong(portfolioData))
        .style({ 'width': '800px', 'height': '500px' })
        .transition().duration(1000)
        .call(chart);

      nv.utils.windowResize(chart.update);
      return chart;
    });
  }
});

function mapStateToProps(state) {
  return {
    portfolioMinutes: state.getIn(['portfolioMinutes'])
  }
}

export const PortfolioChartContainer = connect(
  mapStateToProps
)(PortfolioChart);
