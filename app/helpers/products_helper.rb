module ProductsHelper
  def image(product, width = "200" , height = "150", thumb = true)
    path = if product.image_path.file.try(:exists?)
             thumb ? product.image_path.url : product.image_path.thumb.url
           else
             "http://www.placehold.it/#{height}x#{width}/EFEFEF/AAAAAA&text=no+image"
           end

    image_tag(path, height: height, width: width)
  end

  def render_title title
    truncate(title, :length => 22)
  end
end
