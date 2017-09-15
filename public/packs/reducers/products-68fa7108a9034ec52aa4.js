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
/******/ 	return __webpack_require__(__webpack_require__.s = 130);
/******/ })
/************************************************************************/
/******/ ({

/***/ 130:
/*!***************************************************!*\
  !*** ./app/javascript/packs/reducers/products.js ***!
  \***************************************************/
/*! exports provided: default */
/*! all exports used */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
eval("Object.defineProperty(__webpack_exports__, \"__esModule\", { value: true });\n/* harmony export (immutable) */ __webpack_exports__[\"default\"] = products;\n/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__constants_ActionTypes__ = __webpack_require__(/*! ../constants/ActionTypes */ 47);\nvar _extends = Object.assign || function (target) { for (var i = 1; i < arguments.length; i++) { var source = arguments[i]; for (var key in source) { if (Object.prototype.hasOwnProperty.call(source, key)) { target[key] = source[key]; } } } return target; };\n\n\n\nvar initialState = [{\n  \"id\": 1,\n  \"title\": \"The Little Foxes\",\n  \"description\": \"Corporate Markets Orchestrator\",\n  \"price\": 604,\n  \"status\": \"supplement\",\n  \"calculate\": 1,\n  \"created_at\": \"2017-01-11 06:33:45\",\n  \"updated_at\": \"about 1 month\"\n}, {\n  \"id\": 2,\n  \"title\": \"O Pioneers!\",\n  \"description\": \"District Data Architect\",\n  \"price\": 992,\n  \"status\": \"supplement\",\n  \"calculate\": 79,\n  \"created_at\": \"2017-01-11 06:33:45\",\n  \"updated_at\": \"about 1 month\"\n}];\n\nfunction products() {\n  var state = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : initialState;\n  var action = arguments[1];\n\n  switch (action.type) {\n    case __WEBPACK_IMPORTED_MODULE_0__constants_ActionTypes__[\"RECEIVE_PRODUCTS\"]:\n      return _extends({}, state, {\n        products: action.products\n      });\n    default:\n      return state;\n  }\n}//# sourceURL=[module]\n//# sourceMappingURL=data:application/json;charset=utf-8;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiMTMwLmpzIiwic291cmNlcyI6WyJ3ZWJwYWNrOi8vLy4vYXBwL2phdmFzY3JpcHQvcGFja3MvcmVkdWNlcnMvcHJvZHVjdHMuanM/OTU3YyJdLCJzb3VyY2VzQ29udGVudCI6WyJ2YXIgX2V4dGVuZHMgPSBPYmplY3QuYXNzaWduIHx8IGZ1bmN0aW9uICh0YXJnZXQpIHsgZm9yICh2YXIgaSA9IDE7IGkgPCBhcmd1bWVudHMubGVuZ3RoOyBpKyspIHsgdmFyIHNvdXJjZSA9IGFyZ3VtZW50c1tpXTsgZm9yICh2YXIga2V5IGluIHNvdXJjZSkgeyBpZiAoT2JqZWN0LnByb3RvdHlwZS5oYXNPd25Qcm9wZXJ0eS5jYWxsKHNvdXJjZSwga2V5KSkgeyB0YXJnZXRba2V5XSA9IHNvdXJjZVtrZXldOyB9IH0gfSByZXR1cm4gdGFyZ2V0OyB9O1xuXG5pbXBvcnQgeyBSRUNFSVZFX1BST0RVQ1RTIH0gZnJvbSAnLi4vY29uc3RhbnRzL0FjdGlvblR5cGVzJztcblxudmFyIGluaXRpYWxTdGF0ZSA9IFt7XG4gIFwiaWRcIjogMSxcbiAgXCJ0aXRsZVwiOiBcIlRoZSBMaXR0bGUgRm94ZXNcIixcbiAgXCJkZXNjcmlwdGlvblwiOiBcIkNvcnBvcmF0ZSBNYXJrZXRzIE9yY2hlc3RyYXRvclwiLFxuICBcInByaWNlXCI6IDYwNCxcbiAgXCJzdGF0dXNcIjogXCJzdXBwbGVtZW50XCIsXG4gIFwiY2FsY3VsYXRlXCI6IDEsXG4gIFwiY3JlYXRlZF9hdFwiOiBcIjIwMTctMDEtMTEgMDY6MzM6NDVcIixcbiAgXCJ1cGRhdGVkX2F0XCI6IFwiYWJvdXQgMSBtb250aFwiXG59LCB7XG4gIFwiaWRcIjogMixcbiAgXCJ0aXRsZVwiOiBcIk8gUGlvbmVlcnMhXCIsXG4gIFwiZGVzY3JpcHRpb25cIjogXCJEaXN0cmljdCBEYXRhIEFyY2hpdGVjdFwiLFxuICBcInByaWNlXCI6IDk5MixcbiAgXCJzdGF0dXNcIjogXCJzdXBwbGVtZW50XCIsXG4gIFwiY2FsY3VsYXRlXCI6IDc5LFxuICBcImNyZWF0ZWRfYXRcIjogXCIyMDE3LTAxLTExIDA2OjMzOjQ1XCIsXG4gIFwidXBkYXRlZF9hdFwiOiBcImFib3V0IDEgbW9udGhcIlxufV07XG5cbmV4cG9ydCBkZWZhdWx0IGZ1bmN0aW9uIHByb2R1Y3RzKCkge1xuICB2YXIgc3RhdGUgPSBhcmd1bWVudHMubGVuZ3RoID4gMCAmJiBhcmd1bWVudHNbMF0gIT09IHVuZGVmaW5lZCA/IGFyZ3VtZW50c1swXSA6IGluaXRpYWxTdGF0ZTtcbiAgdmFyIGFjdGlvbiA9IGFyZ3VtZW50c1sxXTtcblxuICBzd2l0Y2ggKGFjdGlvbi50eXBlKSB7XG4gICAgY2FzZSBSRUNFSVZFX1BST0RVQ1RTOlxuICAgICAgcmV0dXJuIF9leHRlbmRzKHt9LCBzdGF0ZSwge1xuICAgICAgICBwcm9kdWN0czogYWN0aW9uLnByb2R1Y3RzXG4gICAgICB9KTtcbiAgICBkZWZhdWx0OlxuICAgICAgcmV0dXJuIHN0YXRlO1xuICB9XG59XG5cblxuLy8vLy8vLy8vLy8vLy8vLy8vXG4vLyBXRUJQQUNLIEZPT1RFUlxuLy8gLi9hcHAvamF2YXNjcmlwdC9wYWNrcy9yZWR1Y2Vycy9wcm9kdWN0cy5qc1xuLy8gbW9kdWxlIGlkID0gMTMwXG4vLyBtb2R1bGUgY2h1bmtzID0gMCA4IDkiXSwibWFwcGluZ3MiOiJBQUFBO0FBQUE7QUFBQTtBQUFBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBIiwic291cmNlUm9vdCI6IiJ9\n//# sourceURL=webpack-internal:///130\n");

/***/ }),

/***/ 47:
/*!*******************************************************!*\
  !*** ./app/javascript/packs/constants/ActionTypes.js ***!
  \*******************************************************/
/*! exports provided: REQUEST_PRODUCTS, RECEIVE_PRODUCTS */
/*! all exports used */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
eval("Object.defineProperty(__webpack_exports__, \"__esModule\", { value: true });\n/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, \"REQUEST_PRODUCTS\", function() { return REQUEST_PRODUCTS; });\n/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, \"RECEIVE_PRODUCTS\", function() { return RECEIVE_PRODUCTS; });\nvar REQUEST_PRODUCTS = 'REQUEST_PRODUCTS';\nvar RECEIVE_PRODUCTS = 'RECEIVE_PRODUCTS';//# sourceURL=[module]\n//# sourceMappingURL=data:application/json;charset=utf-8;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiNDcuanMiLCJzb3VyY2VzIjpbIndlYnBhY2s6Ly8vLi9hcHAvamF2YXNjcmlwdC9wYWNrcy9jb25zdGFudHMvQWN0aW9uVHlwZXMuanM/MjE0MyJdLCJzb3VyY2VzQ29udGVudCI6WyJleHBvcnQgdmFyIFJFUVVFU1RfUFJPRFVDVFMgPSAnUkVRVUVTVF9QUk9EVUNUUyc7XG5leHBvcnQgdmFyIFJFQ0VJVkVfUFJPRFVDVFMgPSAnUkVDRUlWRV9QUk9EVUNUUyc7XG5cblxuLy8vLy8vLy8vLy8vLy8vLy8vXG4vLyBXRUJQQUNLIEZPT1RFUlxuLy8gLi9hcHAvamF2YXNjcmlwdC9wYWNrcy9jb25zdGFudHMvQWN0aW9uVHlwZXMuanNcbi8vIG1vZHVsZSBpZCA9IDQ3XG4vLyBtb2R1bGUgY2h1bmtzID0gMCAyIDggOSAxMCAxMSJdLCJtYXBwaW5ncyI6IkFBQUE7QUFBQTtBQUFBO0FBQUE7QUFDQSIsInNvdXJjZVJvb3QiOiIifQ==\n//# sourceURL=webpack-internal:///47\n");

/***/ })

/******/ });