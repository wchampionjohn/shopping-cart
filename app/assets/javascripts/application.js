// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require_tree ./metronic/
//= require_tree ../../../vendor/assets/javascripts/
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

    if($('.date-picker').length) {
        $('.date-picker').datepicker({
            orientation: "left",
            autoclose: true,
            format: 'yyyy-mm-dd'
        });
    }

    $(window).resize(function(){
        $(".page-content").css('min-height', $(window).height() - 160 + 'px');
    }).resize();

    $("#check_all").click(function(){
        $("#table-list tbody").find('input:checkbox').prop('checked', $(this).prop('checked'));
        App.updateUniform();
    });

    $("#delete-btn").click(function () {

        var $checked = $("#table-list tbody").find('input:checkbox:checked'),
            $this = $(this);

        if (!$checked.length) {
            toastr.error('請勾選要刪除的項目', 'Error');
            return;
        }

        var id = $("#table-list tbody").find('input:checkbox:checked').map(function () {
            return $(this).val();
        }).toArray();

        var confirmMessage = $(this).data('confirm-message') || '確定刪除？';

        if (confirm(confirmMessage)) {

            $.ajax({
                url: $(this).data('url'),
                method: 'DELETE',
                data: {
                    id: id
                }
            }).done(function () {
                $checked.closest('tr').remove();
            }).fail(function (result) {
                toastr.error(result.responseJSON.message, 'Error');
            });
        }
    });
});

var modalAjax = function(modal_id, form_id) {

    var $modal = $("#" + modal_id);
    $modal.on('ajax:error', "#" + form_id, function(xhr, status, error){
      var message = '<p class="alert alert-danger">' + status.responseJSON.message + '</p>';
      $modal.find('.modal-body').prepend(message);
      $modal.find('button').button('reset');
    }).on('ajax:beforeSend', '#' + form_id, function(){
      $modal.find('.alert').remove().end().find('button').button('loading');
    }).on('ajax:success', function(xhr, status, error) {
      window.location.reload();
    });
};

var TableList = function () {

    return {
        checked_id: function () {
            return $("#table-list tbody").find('input:checkbox:checked').map(function () {
                return $(this).val();
            }).toArray();
        }
    }

}();
