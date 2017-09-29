import { combineReducers } from 'redux'
import { products, keyword, isEditMode, selectedProductIds, editingProducts, pagination } from './products'

const rootReducer = combineReducers({
  products,
  keyword,
  isEditMode,
  editingProducts,
  selectedProductIds,
  pagination
})

export default rootReducer
