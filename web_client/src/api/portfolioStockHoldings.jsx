import ReduxThunk from 'redux-thunk';
import axiosInstance from '../config/axios';

export default {
  getPortfolioStockHoldings(portfolioId) {
    return axiosInstance.get(`/stock_holdings`)
  }
}
