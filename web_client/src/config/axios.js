import axios from 'axios';

import serverConfig from '../../serverConfig.json';
const protocol = 'http://';

let axiosInstance = axios.create({
  baseURL: `${protocol}${serverConfig.API_LOCATION}:4000/api/v1`
});

module.exports = axiosInstance;
