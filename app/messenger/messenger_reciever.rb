require 'facebook/messenger'
require 'httparty'
require 'whatlanguage'
#require 'haversine'
require 'json'
#require "unidecoder"
include Facebook::Messenger

MessengerConfig.init
@@wl = WhatLanguage.new(:english, :arabic, :french)
#
#
#
def handle_quick_reply (sender_id, payload, message=nil, locale=nil)
  case payload.chomp
    when MessengerConstants::LOCALE_FR, MessengerConstants::LOCALE_AR, MessengerConstants::LOCALE_EN
      payload = payload.gsub!(MessengerConstants::LOCALE + '_', '').downcase
      MessengerController.instance.update_profile(sender_id, {:locale => payload})
    else
      if payload.start_with?(MessengerConstants::CATEGORY_SELECT_PREFIX)
        selected_category = payload.gsub!(MessengerConstants::CATEGORY_SELECT_PREFIX, '')
        quick_replies = MessengerController.instance.get_category_search_choices(sender_id, selected_category)
        message.reply(
            text: I18n.t("You are looking for ?", {:locale => locale}),
            quick_replies: quick_replies
        )
      else
        if payload.start_with?(MessengerConstants::CATEGORY_PRODUCTS_SEARCH_PREFIX)
          selected_categories = [payload.gsub!(MessengerConstants::CATEGORY_PRODUCTS_SEARCH_PREFIX, '')]
          launches = MessengerController.instance.top_products(sender_id, [13])
          if launches.length < 1
            message.reply({
                              text: I18n.t('No item was found, try another cateogories'),
                              quick_replies: MessengerController.instance.get_categories(sender_id)
                          })
          else
            message.reply(
                attachment: {
                    type: 'template',
                    payload: {
                        template_type: 'generic',
                        elements: launches
                    }
                }
            )
          end
        else
          if payload.start_with?(MessengerConstants::CATEGORY_BRANDS_SEARCH_PREFIX)
            selected_categories = [payload.gsub!(MessengerConstants::CATEGORY_BRANDS_SEARCH_PREFIX, '')]
            brands = MessengerController.instance.top_brands(sender_id, selected_categories)
            message.reply(
                attachment: {
                    type: 'template',
                    payload: {
                        template_type: 'generic',
                        elements: brands
                    }
                }
            )
          end
        end
      end
  end
end

def handle_post_back (sender_id, payload)
  if payload.start_with?(MessengerConstants::BRAND_SELECT_PREFIX)
    unless message.nil?
      selected_brand = [payload.gsub!(MessengerConstants::BRAND_SELECT_PREFIX, '')]
      launches = MessengerController.instance.brand_products(sender_id, selected_brand)
      message.reply(
          attachment: {
              type: 'template',
              payload: {
                  template_type: 'generic',
                  elements: launches
              }
          }
      )
    end
  else
    message= {
        attachment: {
            type: 'template',
            payload: {
                template_type: 'generic',
                elements: top['brands']
            }
        }
    }
  end
end

def other(sender_id, text)
  # handle pnl
  top = MessengerController.instance.top_brands(sender_id)
  Bot.deliver({
                  recipient: {
                      id: sender_id
                  },
                  message: {
                      text: @@wl.language(text)
                  }
              }, access_token: MessengerController.get_token)

end

# Logic for postbacks
Bot.on :postback do |postback|
  puts postback.inspect
  sender_id = postback.sender['id']
  locale = MessengerController.instance.get_locale(sender_id)
  case postback.payload
    when MessengerConstants::GETTING_STARTED
      message = {
          text: MessengerController.get_getting_started(sender_id)
      }
    when MessengerConstants::LOCATION
      message = {
          text: I18n.t('Please pick your location', {:locale => locale}),
          quick_replies: [
              {
                  content_type: 'location',
              }
          ]
      }
    # change locale
    when MessengerConstants::LOCALE
      message = {
          text: I18n.t('Please choose your  language', {:locale => locale}),
          quick_replies: MessengerConstants::MENU_LOCALE_REPLIES
      }
    when MessengerConstants::SELECT_CATEGORIES
      message= {
          text: I18n.t("Select top categories", {:locale => locale}),
          quick_replies: MessengerController.instance.get_categories(sender_id)
      }
    else
      handle_post_back(sender_id, message.payload)
      return
  end

  Bot.deliver({
                  recipient: {
                      id: sender_id
                  },
                  message: message
              }, access_token: MessengerController.get_token)
end

# Logic for message and shared location
Bot.on :message do |message|
  puts message.inspect
  sender_id = message.sender['id']
  locale = MessengerController.instance.get_locale(sender_id)

  if message.echo?
    puts '########## just echo '
  else
    MessengerController.instance.store_history(sender_id, message)
    if message.attachments
      # if message.attachments[0]['type'] == 'location'
      #   location = [message.attachments[0]['payload']['coordinates']['lat'], message.attachments[0]['payload']['coordinates']['long']]
      #   ratp_closest_stations(location)
      #   message.reply(
      #       attachment: {
      #           type: 'template',
      #           payload: {
      #               template_type: 'button',
      #               text: TEXT[:ask_station],
      #               buttons: @stations_shortlist
      #           }
      #       }
      #   )
      # else
      message.reply({
                        text: MessengerConstants::IDIOMS[:unknown_command],
                        quick_replies: [
                            {
                                content_type: 'location',
                            }
                        ]
                    })
      # end
    elsif message.quick_reply
      handle_quick_reply(sender_id, message.quick_reply, message, locale)
    else
      other(sender_id, message.text)
    end
  end
end
