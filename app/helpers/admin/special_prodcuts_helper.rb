module Admin::SpecialProdcutsHelper
  def special_hint(product, is_show_percent_text = true)
    special = product.special
    if special.percent? && is_show_percent_text
      content_tag(:label, special.human_text_of_percent, class: "label label-warning")
    else
      content_tag(:del, currency(product.price))
    end
  end
end
