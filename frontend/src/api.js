import axios from 'axios';
import snakeobj from 'snakeobj';
import camelobj from 'camelobj';

const { REACT_APP_API_HOST } = process.env;

const instance = axios.create();
instance.defaults.baseURL = REACT_APP_API_HOST;
instance.defaults.headers.common['Content-Type'] = 'application/json';
instance.defaults.headers.common.Accept = 'application/json';

instance.defaults.transformResponse = [
  ...axios.defaults.transformResponse,
  data => camelobj(data),
];

export default instance;
