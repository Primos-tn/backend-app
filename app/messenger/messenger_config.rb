class MessengerConfig
  def self.init


# Greetings first contact
    Facebook::Messenger::Thread.set({
                                        setting_type: 'greeting',
                                        greeting: {
                                            text: MessengerConstants::GETTING_STARTED
                                        },
                                    }, access_token: MessengerController.get_token)
    # Set call to action button when user is about to address bot
    # for the first time.
    Facebook::Messenger::Thread.set({
                                        setting_type: 'call_to_actions',
                                        thread_state: 'new_thread',
                                        call_to_actions: [
                                            {
                                                payload: MessengerConstants::GETTING_STARTED
                                            }
                                        ]
                                    }, access_token: MessengerController.get_token)

# menu
    Facebook::Messenger::Thread.set({
                                        setting_type: 'call_to_actions',
                                        thread_state: 'existing_thread',
                                        call_to_actions: [
                                            {
                                                type: 'postback',
                                                title: 'Categories',
                                                payload: MessengerConstants::SELECT_CATEGORIES
                                            },
                                            {
                                                type: 'postback',
                                                title: 'Language',
                                                payload: MessengerConstants::LOCALE
                                            },
                                            {
                                                type: 'postback',
                                                title: 'Change location',
                                                payload: MessengerConstants::LOCATION
                                            }
                                        ]
                                    },
                                    access_token: MessengerController.get_token
    )
  end
end