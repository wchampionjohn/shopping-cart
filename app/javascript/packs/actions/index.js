import { RECEIVE_PRODUCTS } from '../constants/ActionTypes'
import axios from 'axios';

export const receivePosts = (json) => ({
  type: RECEIVE_PRODUCTS,
  products: json
})

export const fetchPosts = () => dispatch => {
  return axios.get('http://localhost:3000/products.json')
    .then(response => dispatch(receivePosts(response.data)))
}
