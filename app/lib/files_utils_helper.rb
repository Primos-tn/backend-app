require 'find'
require 'fileutils'
module FilesUtilsHelper
  def dir_size?(dir_path)
    total_size = 0
    FileUtils.mkdir_p(dir_path) unless File.directory?(dir_path)

    Find.find(dir_path) do |path|
      if FileTest.directory?(path)
        if File.basename(path)[0] == ?.
          Find.prune # Don't look any further into this directory.
        else
          next
        end
      else
        total_size += FileTest.size(path)
      end
    end
    total_size / 1048576.to_f
  end
end