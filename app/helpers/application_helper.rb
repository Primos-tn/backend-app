module ApplicationHelper

  def hide_side_bar?
    %w(devise).include?(controller_path.split('/').first) or
        %w(company profiles registrations business passwords sessions).include?(controller_name)
  end

  def with_full_header?
    @full_template_page or hide_side_bar?
  end

  def ws_app_host?
    Rails.configuration.wsapp[:host]
  end

  def app_host?
    ENV['HOSTNAME']
  end

  def ws_app_user?
    current_user.id if current_user
  end

  def get_assets_url(url)
     '/media' + (url.start_with?('/')? '' : '/' ).concat(url)
  end

  def trending_brands
    Brand.top(5)
  end

  def category_children(category)
    Category.children(category)
  end

  def humanize_category_name(category)
    category['name' + (locale.equal?(:en) ? '' : '_' + locale.to_s)]
  end

  def humanize_feature_name(category)
    category['name' + (locale.equal?(:en) ? '' : '_' + locale.to_s)]
  end



  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, params.merge(:sort => column, :direction => direction, :page => nil), {:class => css_class}
  end

  def get_location
    GeoUtils::location_from_ip(request)
  end

end
