module ApplicationHelper

  def breadcrumb *items
    content_tag(:ul, class: 'page-breadcrumb') do
      s = ''
      s += content_tag(:li) do
        (link_to("Home", admin_root_path) + content_tag(:i, '', class: 'fa fa-circle')).html_safe
      end
      items.each_with_index do |item, index|
        s +=  content_tag(:li) do
          if index == items.size - 1
            item
          else
            (item + content_tag(:i, '', class: 'fa fa-circle')).html_safe
          end
        end
      end

      s.html_safe
    end
  end

end
