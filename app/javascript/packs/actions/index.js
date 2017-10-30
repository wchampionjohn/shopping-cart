import * as types from '../constants/ActionTypes'
import axios from 'axios';

export const setEditingProducts = (editingProducts) => ({
  type: types.SET_EDITING_PRODUCTS,
  editingProducts
})

export const changeProduct = (editedProduct) => ({
  type: types.CHANGE_PRODUCT,
  editedProduct
})

export const triggerSelectAllProducts = (productIds) => ({
  type: types.TRIGGLE_SELECT_ALL_PRODUCTS,
  productIds
})

export const clearSelectedProductIds = () => ({
  type: types.CLEAR_SELECTED_PRODUCT_IDS
})

export const selectProduct = (productId) => ({
  type: types.SELECT_PRODUCT,
  productId
})

export const turnOffEditMode = () => ({
  type: types.TURN_OFF_EDIT_MODE
})
export const turnOnEditMode = () => ({
  type: types.TURN_ON_EDIT_MODE
})

export const searchKeyword = keyword => ({
  type: types.SEARCH_KEYWORD,
  keyword
})

export const clearKeyword = () => ({
  type: types.CLEAR_KEYWORD
})

export const receivePosts = (reponseData) => ({
  type: types.RECEIVE_PRODUCTS,
  products: reponseData.products,
  pagination: reponseData.meta.pagination
})

export const updateProducts = (products) => ({
  type: types.UPDATE_PRODUCTS,
  products: products
})

export const fetchPosts = (conditions = {}) => dispatch => {

  let url = 'http://localhost:3000/products.json'

  if(Object.keys(conditions).length > 0) {
    url += '?'
    Object.keys(conditions).forEach((column)=> {
      url += `${column}=${conditions[column]}&`
    })
  }

  return axios.get(url)
    .then(response => dispatch(receivePosts(response.data)))
}

export const deleteProduct = (id) => (dispatch) => {
  return axios({
    method: 'delete',
    url: `/products/${id}`,
    data: {
      format: 'json'
    }
  }).then((res) => {
    dispatch({type: types.PRODUCT_DELETE_SUCCESS, id});
  });
}

export const deleteProducts = (ids) => (dispatch) => {
  return axios({
    method: 'delete',
    url: '/products/batch_delete.json',
    data: {
      ids: ids
    }
  }).then((res) => {
    dispatch({type: types.PRODUCTS_DELETE_SUCCESS, ids});
    dispatch(turnOffEditMode())
    dispatch(setEditingProducts({}))
  });
}

export const saveProducts = (products) => dispatch => {
  return axios({
    method: 'post',
    url: '/products/batch_update',
    data: {
      products: products
    }
  }).then((res) => {
    dispatch(updateProducts(products))
    dispatch(turnOffEditMode())
    dispatch(setEditingProducts({}))
    toastr.success('儲存成功', 'Success');
  }).catch((error) => {
    const messages = error.response.data
    let result = ''
    for (const id in messages) {
      result = `id: ${id}  <br />`;
      messages[id].forEach((message) => {
        result += ` ${message} <br />`
      })
      toastr.error(result, 'Error');
    }
  });
}
