//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require_tree ./metronic/
//= require toastr.min
//= require rails-ujs
//

toastr.options = {
  "closeButton": false,
  "newestOnTop": false,
  "progressBar": false,
  "positionClass": "toast-top-center",
  "preventDuplicates": false,
  "onclick": null,
  "showDuration": "300",
  "hideDuration": "1000",
  "timeOut": "5000",
  "extendedTimeOut": "1000",
  "showEasing": "swing",
  "hideEasing": "linear",
  "showMethod": "fadeIn",
  "hideMethod": "fadeOut"
};

$(document).on('ready page:load', function() {
  App.init();
  Layout.init();
});
