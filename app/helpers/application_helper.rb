module ApplicationHelper

  def is_devise?
    %w(devise).include?(controller_path.split('/').first) or controller_name == 'company'
  end

  def with_full_header?
    is_devise?
  end


  def get_assets_url(url)
     '/images/'.concat(url)
  end


  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, params.merge(:sort => column, :direction => direction, :page => nil), {:class => css_class}
  end



end
