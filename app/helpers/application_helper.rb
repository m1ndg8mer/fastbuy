module ApplicationHelper
  # Returns the full title on a per-page basis.
  def full_title(page_title = '')
    base_title = 'FastBuy'
    if page_title.empty?
      base_title
    else
      page_title + ' | ' + base_title
    end
  end

  # Returns the panel title
  def panel_title(count, title)
    content_tag(:h2, count) + content_tag(:h4, title)
  end
end
