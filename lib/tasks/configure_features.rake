namespace :configure do
  desc "Configuring system features"
  task features: :environment do
    open(Rails.root.join('lib', 'tasks', 'seeds', '_features.csv')) do |categories|
      categories.read.each_line.with_index do |feature, index|
        next if index == 0
        name, icon, name_ar, name_fr,  = feature.chomp.split(',')
        begin
          Feature.create(:name => name, :name_fr => name_fr, :name_ar => name_ar, :icon => icon )
        rescue => ex
          logger.error ex.message
        end

      end
    end
  end
end