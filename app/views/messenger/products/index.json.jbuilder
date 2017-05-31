json.list @items do |entry|
  json.title entry.product.name + ' (' + entry.product.brand.name + ')'
  if entry.product.pictures.length
    json.image_url app_host? + get_assets_url(entry.product.pictures[0].file.url)
  else
    json.image_url app_host? + get_assets_url("FIXME")
  end
  json.subtitle "FIXME"
  json.default_action do
    json.type "web_url" # get path
    json.url app_host? + '/products/' + entry.id.to_s
  end
  json.buttons do
    json.array!([0]) do
      json.type "web_url" # get path
      json.url app_host? + '/products/' + entry.id.to_s
      json.title I18n.t("Show")
      #     "type": "web_url",
      #     "url": "https://peterssendreceiveapp.ngrok.io/collection",
      #     "messenger_extensions": true,
      # "webview_height_ratio": "tall",
      #     "fallback_url": "https://peterssendreceiveapp.ngrok.io/"
    end
  end
end
