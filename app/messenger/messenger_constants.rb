class MessengerConstants
  SELECT_CATEGORIES = 'SELECT_CATEGORIES'
  MENU_HELP = 'MENU_HELP'
  LOCATION = 'LOCATION'
  FULL_ADDRESS = 'FULL_ADDRESS'
  TYPE_LOCATION = [{content_type: 'location'}]
  GETTING_STARTED = 'GETTING_STARTED'
  LOCALE = 'LOCALE'
  LOCALE_AR = 'LOCALE_AR'
  LOCALE_FR = 'LOCALE_FR'
  LOCALE_EN = 'LOCALE_EN'
  CATEGORY_SELECT_PREFIX  = 'CATEGORY_PAYLOAD_'
  CATEGORY_PRODUCTS_SEARCH_PREFIX  = 'CATEGORY_PRODUCTS_SEARCH_'
  CATEGORY_BRANDS_SEARCH_PREFIX  = 'CATEGORY_BRANDS_SEARCH_'
  BRAND_SELECT_PREFIX  = 'BRAND_PAYLOAD_'
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