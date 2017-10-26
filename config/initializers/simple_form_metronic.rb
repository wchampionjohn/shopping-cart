# Use this setup block to configure all options available in SimpleForm.
SimpleForm.setup do |config|
  config.error_notification_class = 'alert alert-danger'
  config.button_class = 'btn btn-default'
  config.boolean_label_class = nil
  config.item_wrapper_tag = :label

  config.wrappers :vertical_form, tag: 'div', class: 'form-group', error_class: 'has-error' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly

    b.use :label, class: 'col-md-2 control-label'

    b.wrapper tag: 'div', class: 'col-md-10' do |ba|
      ba.use :input, class: 'form-control'
      ba.use :error, wrap_with: { tag: 'span', class: 'help-block' }
      ba.use :hint,  wrap_with: { tag: 'p', class: 'help-block' }
    end

  end

  config.wrappers :horizontal_file_input, tag: 'div', class: 'form-group', error_class: 'has-error' do |b|

    b.use :html5
    b.optional :readonly

    b.use :label, class: 'col-md-2 control-label'

    b.wrapper tag: 'div', class: 'col-md-10' do |ba|
      ba.use :input, class: 'form-control'
      ba.use :error, wrap_with: { tag: 'span', class: 'help-block' }
      ba.use :hint,  wrap_with: { tag: 'p', class: 'help-block' }
    end
  end

  config.wrappers :vertical_boolean, tag: 'div', class: 'form-group', error_class: 'has-error' do |b|
    b.use :html5
    b.optional :readonly

    b.wrapper tag: 'div', class: 'checkbox' do |ba|
      ba.use :label_input
    end

    b.use :error, wrap_with: { tag: 'span', class: 'help-block' }
    b.use :hint,  wrap_with: { tag: 'p', class: 'help-block' }
  end

  config.wrappers :vertical_radio_and_checkboxes, tag: 'div', class: 'form-group', error_class: 'has-error' do |b|
    b.use :html5
    b.optional :readonly
    b.use :label, class: 'control-label'
    b.use :input
    b.use :error, wrap_with: { tag: 'span', class: 'help-block' }
    b.use :hint,  wrap_with: { tag: 'p', class: 'help-block' }
  end

  config.wrappers :horizontal_form, tag: 'div', class: 'form-group', error_class: 'has-error' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly
    b.use :label, class: 'col-sm-3 control-label'

    b.wrapper tag: 'div', class: 'col-sm-9' do |ba|
      ba.use :input, class: 'form-control'
      ba.use :error, wrap_with: { tag: 'span', class: 'help-block' }
      ba.use :hint,  wrap_with: { tag: 'p', class: 'help-block' }
    end
  end

  config.wrappers :horizontal_boolean, tag: 'div', class: 'form-group', error_class: 'has-error' do |b|

    b.use :html5
    b.optional :readonly

    b.use :label, class: 'col-md-2 control-label'

    b.wrapper tag: 'div', class: 'col-md-10' do |ba|
      ba.wrapper tag: 'div', class: 'checkbox-list' do |bc|
        bc.wrapper tag: 'label', class: 'checkbox-inline' do |bd|
          bd.use :input
        end
      end
    end

    # b.use :html5
    # b.optional :readonly
    #
    # b.wrapper tag: 'div', class: 'col-sm-offset-3 col-sm-9' do |wr|
    #   wr.wrapper tag: 'div', class: 'checkbox' do |ba|
    #     ba.use :label_input, class: 'col-sm-9'
    #   end
    #
    #   wr.use :error, wrap_with: { tag: 'span', class: 'help-block' }
    #   wr.use :hint,  wrap_with: { tag: 'p', class: 'help-block' }
    # end
  end

  config.wrappers :horizontal_checkboxes, tag: 'div', class: 'form-group', error_class: 'has-error' do |b|

    b.use :html5
    b.optional :readonly

    b.use :label, class: 'col-md-2 control-label'

    b.wrapper tag: 'div', class: 'col-md-10' do |ba|
      ba.wrapper tag: 'div', class: 'checkbox-list' do |bc|
        bc.use :input
      end
      # ba.use :error, wrap_with: { tag: 'span', class: 'help-block' }
      # ba.use :hint,  wrap_with: { tag: 'p', class: 'help-block' }
    end
  end

  config.wrappers :horizontal_radio_buttons, tag: 'div', class: 'form-group', error_class: 'has-error' do |b|

    b.use :html5
    b.optional :readonly

    b.use :label, class: 'col-md-2 control-label'

    b.wrapper tag: 'div', class: 'col-md-10' do |ba|
      ba.wrapper tag: 'div', class: 'radio-list' do |bc|
        bc.use :input
      end
      # ba.use :error, wrap_with: { tag: 'span', class: 'help-block' }
      # ba.use :hint,  wrap_with: { tag: 'p', class: 'help-block' }
    end
  end

  config.wrappers :inline_form, tag: 'div', class: 'form-group', error_class: 'has-error' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly
    b.use :label, class: 'sr-only'

    b.use :input, class: 'form-control'
    b.use :error, wrap_with: { tag: 'span', class: 'help-block' }
    b.use :hint,  wrap_with: { tag: 'p', class: 'help-block' }
  end

  config.wrappers :static, tag: 'div', class: 'form-group' do |b|

    b.use :html5
    b.use :label, class: 'col-md-2 control-label'

    b.wrapper tag: 'div', class: 'col-md-10' do |ba|
      ba.wrapper tag: 'p', class: 'form-control-static' do |bb|
        bb.use :input
      end
    end

  end

  # Wrappers for forms and inputs using the Bootstrap toolkit.
  # Check the Bootstrap docs (http://getbootstrap.com)
  # to learn about the different styles for forms and inputs,
  # buttons and other elements.
  config.default_wrapper = :vertical_form
  config.wrapper_mappings = {
    check_boxes: :horizontal_checkboxes,
    radio_buttons: :horizontal_radio_buttons,
    file: :horizontal_file_input,
    boolean: :horizontal_boolean,
    static: :static
  }
end
