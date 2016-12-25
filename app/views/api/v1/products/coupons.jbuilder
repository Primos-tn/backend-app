json.result do
  json.coupons @items do |entry|
    json.value entry.value
    json.id entry.id
    unless entry.image_qr_code.file.nil?
      json.image_qr_code get_assets_url(entry.image_qr_code.url)
    end
    json.expires entry.expires
  end
end