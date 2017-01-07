import ReduxThunk from 'redux-thunk';
import axiosInstance from '../config/axios';

export default {
  getPortfolioCashHoldings(portfolioId) {
    return axiosInstance.get(`/cash_holdings`)
  }
}
