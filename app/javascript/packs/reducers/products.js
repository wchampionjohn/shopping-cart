import {
  RECEIVE_PRODUCTS,
  SEARCH_KEYWORD,
  CLEAR_KEYWORD,
  CLOSE_EDIT_MODE,
  SWITCH_EDIT_MODE,
  SELECT_PRODUCT,
  TRIGGLE_SELECT_ALL_PRODUCTS,
  SET_EDITING_PRODUCTS,
  CHANGE_PRODUCT,
  SAVE_PRODUCTS,
  PRODUCT_DELETE_SUCCESS,
  PRODUCTS_DELETE_SUCCESS,
  UPDATE_PRODUCTS,
  CLEAR_SELECTED_PRODUCT_IDS
} from '../constants/ActionTypes'


export const editingProducts = (state = {}, action) => {
  switch (action.type) {
    case SET_EDITING_PRODUCTS:
      return action.editingProducts
    case CHANGE_PRODUCT:
      return Object.assign(state, action.editedProduct)
    default:
      return state
  }
}

export const selectedProductIds = (state = [], action) => {
  switch (action.type) {
    case SELECT_PRODUCT:
      if(state.indexOf(action.productId) !== -1) {
        return state.filter(productId => productId !== action.productId)
      }
      return [...state, action.productId]
    case TRIGGLE_SELECT_ALL_PRODUCTS:
      return action.productIds
    case CLEAR_SELECTED_PRODUCT_IDS:
      return []
    default:
      return state
  }
}

export const isEditMode = (state = false, action) => {
  switch (action.type) {
    case SWITCH_EDIT_MODE:
      return true
    case CLOSE_EDIT_MODE:
      return false
    default:
      return state;
  }
}

export const keyword = (state = '', action) => {
  switch (action.type) {
    case SEARCH_KEYWORD:
      return action.keyword
    case CLEAR_KEYWORD:
      return ''
    default:
      return state
  }
}

export const products = (state = [], action) => {
  switch (action.type) {
    case RECEIVE_PRODUCTS:
    case UPDATE_PRODUCTS:
      return action.products
    case PRODUCT_DELETE_SUCCESS:
      return state.filter(product =>
        product.id !== action.id
      )
    case PRODUCTS_DELETE_SUCCESS:
      return state.filter(product =>
        action.ids.indexOf(product.id) === -1
      )
    default:
      return state
  }
}

export const pagination = (state = { total_count: 10 } , action) => {
  switch (action.type) {
    case RECEIVE_PRODUCTS:
      return action.pagination
    default:
      return state
  }
}
