import * as types from '../constants/ActionTypes'

export const editingProducts = (state = {}, action) => {
  switch (action.type) {
    case types.SET_EDITING_PRODUCTS:
      return action.editingProducts
    case types.CHANGE_PRODUCT:
      return Object.assign(state, action.editedProduct)
    default:
      return state
  }
}

export const selectedProductIds = (state = [], action) => {
  switch (action.type) {
    case types.SELECT_PRODUCT:
      if(state.indexOf(action.productId) !== -1) {
        return state.filter(productId => productId !== action.productId)
      }
      return [...state, action.productId]
    case types.TRIGGLE_SELECT_ALL_PRODUCTS:
      return action.productIds
    case types.CLEAR_SELECTED_PRODUCT_IDS:
      return []
    default:
      return state
  }
}

export const isEditMode = (state = false, action) => {
  switch (action.type) {
    case types.TURN_ON_EDIT_MODE:
      return true
    case types.TURN_OFF_EDIT_MODE:
      return false
    default:
      return state;
  }
}

export const keyword = (state = '', action) => {
  switch (action.type) {
    case types.SEARCH_KEYWORD:
      return action.keyword
    case types.CLEAR_KEYWORD:
      return ''
    default:
      return state
  }
}

export const products = (state = [], action) => {
  switch (action.type) {
    case types.RECEIVE_PRODUCTS:
    case types.UPDATE_PRODUCTS:
      return action.products
    case types.PRODUCT_DELETE_SUCCESS:
      return state.filter(product =>
        product.id !== action.id
      )
    case types.PRODUCTS_DELETE_SUCCESS:
      return state.filter(product =>
        action.ids.indexOf(product.id) === -1
      )
    default:
      return state
  }
}

export const pagination = (state = { total_count: 10 } , action) => {
  switch (action.type) {
    case types.RECEIVE_PRODUCTS:
      return action.pagination
    default:
      return state
  }
}
