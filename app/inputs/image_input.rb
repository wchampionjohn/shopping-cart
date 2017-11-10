class ImageInput < SimpleForm::Inputs::FileInput
  def input(wrapper_options)
    uploaded = !!object.send(attribute_name).file
    file_class = uploaded ? 'fileinput-exists' : 'fileinput-new'
    preview_class = uploaded ? 'fileinput-preview fileinput-exists thumbnail' : 'fileinput-preview thumbnail'
    preview_image = uploaded ?  '<img src="' + object.send(attribute_name).thumb.url + '" alt="">'  : ' '

    merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)
    file =  @builder.file_field(attribute_name, merged_input_options)

    html = '<div class="fileinput ' + file_class + '" data-provides="fileinput">
              <div class="' + preview_class + '" data-trigger="fileinput" style="width: 200px; height: 150px;">' + preview_image + '</div>
              <div>
                <span class="btn red btn-outline btn-file">
                <span class="fileinput-new"> Select image </span>
                <span class="fileinput-exists"> Change </span>' + file + '</span>'
    html +=    '<a href="javascript:;" class="btn red fileinput-exists" data-dismiss="fileinput"> Remove </a>
              </div>
            </div>'
    html.html_safe
  end
end
