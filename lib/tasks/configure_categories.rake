namespace :configure do
  desc "Configuring system categories"
  task categories: :environment do
# Countries seed
    #Category.delete_all
    open(Rails.root.join('lib', 'tasks', 'seeds', 'categories.csv')) do |categories|
      categories.read.each_line.with_index do |category, index|
        next if index == 0
        name, name_fr, name_ar, icon_class_name = category.chomp.split('|')
        puts icon_class_name
        puts '************************'
        begin
          Category.create(:name => name, :name_fr => name_fr, :name_ar => name_ar, :icon_class_name => icon_class_name )
        rescue => ex
          logger.error ex.message
        end

      end
    end
  end
end