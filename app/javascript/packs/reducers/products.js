import { RECEIVE_PRODUCTS } from '../constants/ActionTypes'

export default function products(state = [], action) {
  switch (action.type) {
    case RECEIVE_PRODUCTS:
      return action.products
    default:
      return state
  }
}

