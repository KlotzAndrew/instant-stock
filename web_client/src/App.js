import React, { Component } from 'react';
import {PortfolioContainer} from './components/portfolio';
import axiosInstance from './config/axios';
import {createStore} from 'redux';
import reducer from './reducer';
import { Provider } from 'react-redux';
const store = createStore(reducer);

export default class App extends Component {
  componentDidMount() {
    this._getPormoPortfolio();
  }

  render() {
    return (
      <Provider store={store}>
        <div>
          <PortfolioContainer />
        </div>
      </Provider>
    );
  }

  _getPormoPortfolio = () => {
    function apiCall() {
      return axiosInstance.get('/promo')
                          .then(function(response) {
                            console.log(response.data);
                            store.dispatch({
                              type: 'SET_PORTFOLIO',
                              state: {
                                portfolio: response.data.portfolio
                              }
                            });
                          })
                          .catch(function(response) {
                            console.log(response);
                          });
    }

    apiCall();
  };
}

