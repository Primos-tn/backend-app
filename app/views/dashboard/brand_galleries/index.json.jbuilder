json.list(@gallery) do |item|
  json.extract! item, :id, :name, :file
end

