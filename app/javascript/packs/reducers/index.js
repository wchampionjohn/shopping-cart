import { combineReducers } from 'redux'
import { products, keyword, isEditMode, selectedProductIds, editingProducts, statuses, pagination } from './products'

const rootReducer = combineReducers({
  products,
  keyword,
  isEditMode,
  editingProducts,
  selectedProductIds,
  statuses,
  pagination
})

export default rootReducer
