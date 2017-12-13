class DaterangeInput < SimpleForm::Inputs::FileInput
  def input(wrapper_options)
    '<input type="text" class="form-control" name="from">'
  end
end
