namespace :configure do
  desc "Configuring system categories"
  task categories: :environment do
# Countries seed
    #Category.delete_all
    open(Rails.root.join('lib', 'tasks', 'seeds', 'categories')) do |categories|
      categories.read.each_line do |category|
        name, name_fr, name_ar, icon_class_name = category.chomp.split('|')
        puts icon_class_name
        puts '************************'
        Category.create!(:name => name, :name_fr => name_fr, :name_ar => name_ar, :icon_class_name => icon_class_name )
      end
    end
  end
end