/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId]) {
/******/ 			return installedModules[moduleId].exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.l = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// define getter function for harmony exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		if(!__webpack_require__.o(exports, name)) {
/******/ 			Object.defineProperty(exports, name, {
/******/ 				configurable: false,
/******/ 				enumerable: true,
/******/ 				get: getter
/******/ 			});
/******/ 		}
/******/ 	};
/******/
/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};
/******/
/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "/packs/";
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = 84);
/******/ })
/************************************************************************/
/******/ ({

/***/ 47:
/*!*******************************************************!*\
  !*** ./app/javascript/packs/constants/ActionTypes.js ***!
  \*******************************************************/
/*! exports provided: REQUEST_PRODUCTS, RECEIVE_PRODUCTS */
/*! all exports used */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
eval("Object.defineProperty(__webpack_exports__, \"__esModule\", { value: true });\n/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, \"REQUEST_PRODUCTS\", function() { return REQUEST_PRODUCTS; });\n/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, \"RECEIVE_PRODUCTS\", function() { return RECEIVE_PRODUCTS; });\nvar REQUEST_PRODUCTS = 'REQUEST_PRODUCTS';\nvar RECEIVE_PRODUCTS = 'RECEIVE_PRODUCTS';//# sourceURL=[module]\n//# sourceMappingURL=data:application/json;charset=utf-8;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiNDcuanMiLCJzb3VyY2VzIjpbIndlYnBhY2s6Ly8vLi9hcHAvamF2YXNjcmlwdC9wYWNrcy9jb25zdGFudHMvQWN0aW9uVHlwZXMuanM/MjE0MyJdLCJzb3VyY2VzQ29udGVudCI6WyJleHBvcnQgdmFyIFJFUVVFU1RfUFJPRFVDVFMgPSAnUkVRVUVTVF9QUk9EVUNUUyc7XG5leHBvcnQgdmFyIFJFQ0VJVkVfUFJPRFVDVFMgPSAnUkVDRUlWRV9QUk9EVUNUUyc7XG5cblxuLy8vLy8vLy8vLy8vLy8vLy8vXG4vLyBXRUJQQUNLIEZPT1RFUlxuLy8gLi9hcHAvamF2YXNjcmlwdC9wYWNrcy9jb25zdGFudHMvQWN0aW9uVHlwZXMuanNcbi8vIG1vZHVsZSBpZCA9IDQ3XG4vLyBtb2R1bGUgY2h1bmtzID0gMCAyIDggOSAxMCAxMSJdLCJtYXBwaW5ncyI6IkFBQUE7QUFBQTtBQUFBO0FBQUE7QUFDQSIsInNvdXJjZVJvb3QiOiIifQ==\n//# sourceURL=webpack-internal:///47\n");

/***/ }),

/***/ 84:
/*!***********************************************!*\
  !*** ./app/javascript/packs/actions/index.js ***!
  \***********************************************/
/*! exports provided: receivePosts, fetchPosts */
/*! all exports used */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
eval("Object.defineProperty(__webpack_exports__, \"__esModule\", { value: true });\n/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, \"receivePosts\", function() { return receivePosts; });\n/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, \"fetchPosts\", function() { return fetchPosts; });\n/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__constants_ActionTypes__ = __webpack_require__(/*! ../constants/ActionTypes */ 47);\n\n\n//export const requestPosts = () => ({ type: REQUEST_POSTS })\n\nvar receivePosts = function receivePosts(json) {\n  return {\n    type: 'RECEIVE_PRODUCTS',\n    products: json\n  };\n};\n\nvar fetchPosts = function fetchPosts() {\n  return function (dispatch) {\n    return fetch('http://localhost:3000/products.json').then(function (response) {\n      return response.json();\n    }).then(function (json) {\n      return dispatch(receivePosts(json));\n    });\n  };\n};\n\n//export const fetchPostsIfNeeded = reddit => (dispatch, getState) => {\n//if (shouldFetchPosts(getState(), reddit)) {\n//return dispatch(fetchPosts(reddit))\n//}\n//}\n//export function fetchPosts(action$) {\n//return action$.ofType(actionTypes.FETCH_COLLECTION)\n//.map(action => action.payload)\n//.switchMap(params => {\n//return Observable.fromPromise(\n//axios.get(`http://localhost:8081/posts?${querystring.stringify(params)}`)\n//).map(res => postsActions.fetchPostsSuccess(res.data, params));\n//});\n//}//# sourceURL=[module]\n//# sourceMappingURL=data:application/json;charset=utf-8;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiODQuanMiLCJzb3VyY2VzIjpbIndlYnBhY2s6Ly8vLi9hcHAvamF2YXNjcmlwdC9wYWNrcy9hY3Rpb25zL2luZGV4LmpzPzc5ZTUiXSwic291cmNlc0NvbnRlbnQiOlsiaW1wb3J0IHsgUkVDRUlWRV9QUk9EVUNUUyB9IGZyb20gJy4uL2NvbnN0YW50cy9BY3Rpb25UeXBlcyc7XG5cbi8vZXhwb3J0IGNvbnN0IHJlcXVlc3RQb3N0cyA9ICgpID0+ICh7IHR5cGU6IFJFUVVFU1RfUE9TVFMgfSlcblxuZXhwb3J0IHZhciByZWNlaXZlUG9zdHMgPSBmdW5jdGlvbiByZWNlaXZlUG9zdHMoanNvbikge1xuICByZXR1cm4ge1xuICAgIHR5cGU6ICdSRUNFSVZFX1BST0RVQ1RTJyxcbiAgICBwcm9kdWN0czoganNvblxuICB9O1xufTtcblxuZXhwb3J0IHZhciBmZXRjaFBvc3RzID0gZnVuY3Rpb24gZmV0Y2hQb3N0cygpIHtcbiAgcmV0dXJuIGZ1bmN0aW9uIChkaXNwYXRjaCkge1xuICAgIHJldHVybiBmZXRjaCgnaHR0cDovL2xvY2FsaG9zdDozMDAwL3Byb2R1Y3RzLmpzb24nKS50aGVuKGZ1bmN0aW9uIChyZXNwb25zZSkge1xuICAgICAgcmV0dXJuIHJlc3BvbnNlLmpzb24oKTtcbiAgICB9KS50aGVuKGZ1bmN0aW9uIChqc29uKSB7XG4gICAgICByZXR1cm4gZGlzcGF0Y2gocmVjZWl2ZVBvc3RzKGpzb24pKTtcbiAgICB9KTtcbiAgfTtcbn07XG5cbi8vZXhwb3J0IGNvbnN0IGZldGNoUG9zdHNJZk5lZWRlZCA9IHJlZGRpdCA9PiAoZGlzcGF0Y2gsIGdldFN0YXRlKSA9PiB7XG4vL2lmIChzaG91bGRGZXRjaFBvc3RzKGdldFN0YXRlKCksIHJlZGRpdCkpIHtcbi8vcmV0dXJuIGRpc3BhdGNoKGZldGNoUG9zdHMocmVkZGl0KSlcbi8vfVxuLy99XG4vL2V4cG9ydCBmdW5jdGlvbiBmZXRjaFBvc3RzKGFjdGlvbiQpIHtcbi8vcmV0dXJuIGFjdGlvbiQub2ZUeXBlKGFjdGlvblR5cGVzLkZFVENIX0NPTExFQ1RJT04pXG4vLy5tYXAoYWN0aW9uID0+IGFjdGlvbi5wYXlsb2FkKVxuLy8uc3dpdGNoTWFwKHBhcmFtcyA9PiB7XG4vL3JldHVybiBPYnNlcnZhYmxlLmZyb21Qcm9taXNlKFxuLy9heGlvcy5nZXQoYGh0dHA6Ly9sb2NhbGhvc3Q6ODA4MS9wb3N0cz8ke3F1ZXJ5c3RyaW5nLnN0cmluZ2lmeShwYXJhbXMpfWApXG4vLykubWFwKHJlcyA9PiBwb3N0c0FjdGlvbnMuZmV0Y2hQb3N0c1N1Y2Nlc3MocmVzLmRhdGEsIHBhcmFtcykpO1xuLy99KTtcbi8vfVxuXG5cbi8vLy8vLy8vLy8vLy8vLy8vL1xuLy8gV0VCUEFDSyBGT09URVJcbi8vIC4vYXBwL2phdmFzY3JpcHQvcGFja3MvYWN0aW9ucy9pbmRleC5qc1xuLy8gbW9kdWxlIGlkID0gODRcbi8vIG1vZHVsZSBjaHVua3MgPSAwIDIgMTAiXSwibWFwcGluZ3MiOiJBQUFBO0FBQUE7QUFBQTtBQUFBO0FBQUE7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQSIsInNvdXJjZVJvb3QiOiIifQ==\n//# sourceURL=webpack-internal:///84\n");

/***/ })

/******/ });