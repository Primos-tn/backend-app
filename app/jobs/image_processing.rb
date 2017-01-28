class ImageProcessing < ApplicationJob
  REGXP = /\d+:\s*\(\s*\d+,\s*\d+,\s*\d+[,\d+]*\)\s* (?<hex_value>#\h{6})/
  # no sideqick
  self.queue_adapter= :async

  queue_as :default

  rescue_from(Exception) do |error|
    puts error
  end
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  # rescue_from NoMethodError, with: :not_found


  def perform(model)
    require 'open3'
    stdout, stdeerr, status = Open3.capture3('convert', model.file.thumb.path, '-colors', '6', '-format', '%c', 'histogram:info:-')
    dominant_colors = []
    stdout.each_line { |l|
      match = ImageProcessing::REGXP.match(l)
      if match and match[:hex_value]
        dominant_colors << match[:hex_value]
      end
    }
    if dominant_colors.length > 0
      puts 'updating dominant'
      # Use update column and not save to avoid loop on callbacks !
      model.update_column(:dominant_colors, dominant_colors)
    end


  end

end
