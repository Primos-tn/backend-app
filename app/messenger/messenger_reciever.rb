require 'facebook/messenger'
require 'httparty'
#require 'haversine'
require 'json'
#require "unidecoder"
include Facebook::Messenger

MessengerConfig.init

# Logic for postbacks
Bot.on :postback do |postback|
  puts postback.inspect
  sender_id = postback.sender['id']

  case postback.payload
    when 'START'
    when MessengerConstants::LOCATION
      Bot.deliver({
                      recipient: {
                          id: sender_id
                      },
                      message: {
                          text: MessengerConstants::REQUEST_LOCATION,
                          quick_replies: [
                              {
                                  content_type: 'location',
                              }
                          ]
                      },
                  }, access_token: MessengerController.get_token)
    # change locale
    when MessengerConstants::LOCALE
      Bot.deliver({
                      recipient: {
                          id: sender_id
                      },
                      message: {
                          text: MessengerConstants::REQUEST_LOCALE,
                          quick_replies: MessengerConstants::MENU_LOCALE_REPLIES
                      },
                  }, access_token: MessengerController.get_token)
    else
      Bot.deliver({
                      recipient: {
                          id: sender_id
                      },
                      message: {
                          attachment: {
                              type: 'template',
                              payload: {
                                  template_type: 'generic',
                                  elements: top['brands']
                              }
                          }
                      }
                  }, access_token: MessengerController.get_token)
  end
end

# Logic for message and shared location
Bot.on :message do |message|
  puts message.inspect
  sender_id = message.sender['id']
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
    else
      # query = message.text.to_ascii
      # parsed_google_response = google_locate_user(query)
      # if parsed_google_response['status'] == 'OK'
      #   location = parsed_google_response['results'].first['geometry']['location']
      #   ratp_closest_stations([location['lat'],location['lng']])
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
      top = MessengerController.instance.top_brands(ENV['HOSTNAME'], sender_id)
      Bot.deliver({
                      recipient: {
                          id: sender_id
                      },
                      message: {
                          attachment: {
                              type: 'template',
                              payload: {
                                  template_type: 'generic',
                                  elements: top
                              }
                          }
                      }
                  }, access_token: MessengerController.get_token)
      # end
    end
  end
end

