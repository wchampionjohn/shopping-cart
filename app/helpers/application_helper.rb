module ApplicationHelper

  def render_ajax_next_page_link(products)
    link_to(
      "next page",
      products_path(page: products.next_page),
      remote: true,
      class: 'btn btn-primary loading-next-page hidden',
      "data-total": products.total_pages,
      "data-next": products.next_page
    )
  end

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

  def currency number
    number_to_currency(number, unit: "$", precision: 0)
  end

  def is_admin_page?
    controller_path.split('/').first == 'admin'
  end

  def check_icon is_checked
    content_tag(:i, '', class: 'fa fa-check') if is_checked
  end

  def summary setting
    if setting.cut?
      "消費滿 #{currency(setting.condition)} 扣除 #{currency(setting.offer)}"
    elsif setting.percent?
      "消費滿 #{currency(setting.condition)} 打 #{ ((100 - (setting.percent_off)) / 10.0).round(1)} 折"
    end
  end

  def costs_summary rules
    return '無開放任何運費規則' if rules.blank?
    return '一律免運' if rules.last.cost == 0 && rules.last.reach == 0
    return "一律 $ #{rules.first.cost}" if rules.size == 1 && rules.first.reach == 0

    rules.reduce([]) do |result, rule|
      prefix_text = if rule.reach == 0
                     "基本"
                   else
                     "消費滿 $ #{rule.reach} "
                   end
      post_text = if rule.cost == 0
                    " 免運費"
                  else
                    "運費 $ #{rule.cost}"
                  end
      result <<  " #{prefix_text}#{post_text}"
    end.join('<br />').html_safe
  end

end
