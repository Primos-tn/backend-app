require 'find'

module FilesUtils
  def dir_size?(dirname)
    total_size = 0
    Find.find(dirname) do |path|
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