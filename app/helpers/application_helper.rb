module ApplicationHelper
  def full_title(page_title)
    base = "FSIntranet"
    if page_title.empty?
      base
    else
      "#{base} | #{page_title}"
    end
  end

  def menu_link_to(label,path,options = nil)
    li_options = {}
    li_options[:class] = (current_page?(path) ? "active" : nil)
    content_tag('li', link_to(label, path, options), li_options)
  end

  def on_creating?
    action_name == 'new' or action_name == 'create'
  end
end
