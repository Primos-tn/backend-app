class MessengerConstants
  MENU_TAKE_TOUR = 'MENU_TAKE_TOUR'
  MENU_HELP = 'MENU_HELP'
  LOCATION = 'LOCATION'
  LOCALE = 'LOCALE'
  FULL_ADDRESS = 'FULL_ADDRESS'
  TYPE_LOCATION = [{content_type: 'location'}]
  GETTING_STARTED = 'GETTING_STARTED'
  LOCALE_AR = 'LOCALE_AR'
  LOCALE_FR = 'LOCALE_FR'
  LOCALE_EN = 'LOCALE_EN'
  GREETING = "Hello {{user_first_name}} 👋 Moi c\'est Captain Metro 🤖 Je suis là pour te donner les prochains passages du métro de ton choix 🚊 GO !"
  REQUEST_LOCALE = 'Please choose your  language'
  REQUEST_LOCATION = 'Please choose your location'
  MENU_LOCALE_REPLIES = [
      {
          content_type: 'text',
          title: 'Français',
          payload: MessengerConstants::LOCALE_FR
      },
      {
          content_type: 'text',
          title: 'العربية',
          payload: MessengerConstants::LOCALE_AR
      },
      {
          content_type: 'text',
          title: 'English',
          payload: MessengerConstants::LOCALE_EN
      }
  ]

  IDIOMS = {
      not_found: 'There were no results. Type your destination again, please',
      ask_location: 'Type in any destination or send us your location:',
      unknown_command: 'Sorry, I did not recognize your command',
      menu_greeting: 'What do you want to look up?'
  }.freeze

end