import axios from 'axios';


let axiosInstance = axios.create({
  baseURL: 'http://dockermachine:4000'
});

module.exports = axiosInstance;
