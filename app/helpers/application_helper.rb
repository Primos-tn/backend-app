module ApplicationHelper

  def hide_side_bar?
    %w(devise).include?(controller_path.split('/').first) or
        %w(company profiles registrations business passwords sessions).include?(controller_name)
  end

  def with_full_header?
    @full_template_page or hide_side_bar?
  end


  def get_assets_url(url)
     '/media/'.concat(url)
  end


  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, params.merge(:sort => column, :direction => direction, :page => nil), {:class => css_class}
  end

end
