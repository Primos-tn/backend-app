json.list @items do |entry|
  json.title entry.account.username
  json.image_url @host + get_assets_url(entry.cover.to_s)
  json.subtitle @host + get_assets_url(entry.cover.to_s)
  json.default_action do
    json.type "web_url" # get path
    json.url @host + '/brands/' + entry.id.to_s
  end
  json.buttons do
    json.array!([0]) do
      json.type "web_url" # get path
      json.url @host + '/brands/' + entry.id.to_s
      json.title  I18n.t("Follow")
      #     "type": "web_url",
      #     "url": "https://peterssendreceiveapp.ngrok.io/collection",
      #     "messenger_extensions": true,
      # "webview_height_ratio": "tall",
      #     "fallback_url": "https://peterssendreceiveapp.ngrok.io/"
    end
  end
end

# [
#     {
#         "title": "Classic T-Shirt Collection",
#         "image_url": "https://peterssendreceiveapp.ngrok.io/img/collection.png",
#         "subtitle": "See all our colors",
#         "default_action": {
#             "type": "web_url",
#             "url": "https://peterssendreceiveapp.ngrok.io/shop_collection",
#             "messenger_extensions": true,
#             "webview_height_ratio": "tall",
#             "fallback_url": "https://peterssendreceiveapp.ngrok.io/"
#         },
#         "buttons": [
#             {
#                 "title": "View",
#                 "type": "web_url",
#                 "url": "https://peterssendreceiveapp.ngrok.io/collection",
#                 "messenger_extensions": true,
#                 "webview_height_ratio": "tall",
#                 "fallback_url": "https://peterssendreceiveapp.ngrok.io/"
#             }
#         ]
#     },
#     {
#         "title": "Classic White T-Shirt",
#         "image_url": "https://peterssendreceiveapp.ngrok.io/img/white-t-shirt.png",
#         "subtitle": "100% Cotton, 200% Comfortable",
#         "default_action": {
#             "type": "web_url",
#             "url": "https://peterssendreceiveapp.ngrok.io/view?item=100",
#             "messenger_extensions": true,
#             "webview_height_ratio": "tall",
#             "fallback_url": "https://peterssendreceiveapp.ngrok.io/"
#         },
#         "buttons": [
#             {
#                 "title": "Shop Now",
#                 "type": "web_url",
#                 "url": "https://peterssendreceiveapp.ngrok.io/shop?item=100",
#                 "messenger_extensions": true,
#                 "webview_height_ratio": "tall",
#                 "fallback_url": "https://peterssendreceiveapp.ngrok.io/"
#             }
#         ]
#     },
#     {
#         "title": "Classic Blue T-Shirt",
#         "image_url": "https://peterssendreceiveapp.ngrok.io/img/blue-t-shirt.png",
#         "subtitle": "100% Cotton, 200% Comfortable",
#         "default_action": {
#             "type": "web_url",
#             "url": "https://images.pexels.com/photos/147485/pexels-photo-147485.jpeg?w=940&h=650&auto=compress&cs=tinysrgb",
#             "messenger_extensions": true,
#             "webview_height_ratio": "tall",
#             "fallback_url": "https://peterssendreceiveapp.ngrok.io/"
#         },
#         "buttons": [
#             {
#                 "title": "Shop Now",
#                 "type": "web_url",
#                 "url": "https://images.pexels.com/photos/147485/pexels-photo-147485.jpeg?w=940&h=650&auto=compress&cs=tinysrgb",
#                 "messenger_extensions": true,
#                 "webview_height_ratio": "tall",
#                 "fallback_url": "https://peterssendreceiveapp.ngrok.io/"
#             }
#         ]
#     },
#     {
#         "title": "Classic Black T-Shirt",
#         "image_url": "https://images.pexels.com/photos/147485/pexels-photo-147485.jpeg?w=940&h=650&auto=compress&cs=tinysrgb",
#         "subtitle": "100% Cotton, 200% Comfortable",
#         "default_action": {
#             "type": "web_url",
#             "url": "https://peterssendreceiveapp.ngrok.io/view?item=102",
#             "messenger_extensions": true,
#             "webview_height_ratio": "tall",
#             "fallback_url": "https://peterssendreceiveapp.ngrok.io/"
#         },
#         "buttons": [
#             {
#                 "title": "Shop Now",
#                 "type": "web_url",
#                 "url": "https://images.pexels.com/photos/147485/pexels-photo-147485.jpeg?w=940&h=650&auto=compress&cs=tinysrgb",
#                 "messenger_extensions": true,
#                 "webview_height_ratio": "tall",
#                 "fallback_url": "https://peterssendreceiveapp.ngrok.io/"
#             }
#         ]
#     }
# ]