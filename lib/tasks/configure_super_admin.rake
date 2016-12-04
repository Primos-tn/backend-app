namespace :configure do
  desc "Fill admin user "
  _admin = Rails.application.secrets.admin
  task super_admin: :environment do
    Account.create!(username: _admin['username'],
                    email: _admin['email'],
                    password: _admin['password'],
                    is_super_admin: true,
                    password_confirmation: _admin['password'],
                    account_type: Account.accounts_types[:admin]
    )

    puts 'System super admin configuration done !'
  end
end