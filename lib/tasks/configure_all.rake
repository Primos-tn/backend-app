namespace :configure do
  desc "All system configuration"
  task all: :environment do
    Rake::Task['configure:system'].invoke 1
    Rake::Task['configure:super_admin'].invoke 2
    Rake::Task['configure:business_system'].invoke 3
    Rake::Task['db:seed'].invoke 4
    Rake::Task['configure:categories'].invoke 5
    Rake::Task['configure:features'].invoke 6
  end
end