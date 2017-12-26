  const handleConfirm = function(element) {
    if (!allowAction(this)) {
      Rails.stopEverything(element)
    }
  }

  const allowAction = element => {
    if (element.getAttribute('data-confirm-swal') === null) {
      return true
    }

    showConfirmationDialog(element)
    return false
  }

  // Display the confirmation dialog
  const showConfirmationDialog = element => {
    const message = element.getAttribute('data-confirm-swal')
    const text = element.getAttribute('data-text')

    swal({
      title: message || 'Are you sure?',
      text: text || '',
      type: 'warning',
      showCancelButton: true,
      confirmButtonText: '確定',
      cancelButtonText: '取消',
    },
    function(isConfirm) {
      if(isConfirm) {
        element.removeAttribute('data-confirm-swal')
        element.click()
      } else {
        return false
      }

    })
  }

  // Hook the event before the other rails events so it works togeter
  // with `method: :delete`.
  // See https://github.com/rails/rails/blob/master/actionview/app/assets/javascripts/rails-ujs/start.coffee#L69
  document.addEventListener('rails:attachBindings', element => {
    Rails.delegate(document, 'a[data-confirm-swal]', 'click', handleConfirm)
  })

