import ReduxThunk from 'redux-thunk';
import axiosInstance from '../config/axios';

export default {
  getPromoPortfolio() {
    return axiosInstance.get('/promo')
  }
}
