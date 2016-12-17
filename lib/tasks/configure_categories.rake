namespace :configure do
  desc "Configuring system categories"
  task categories: :environment do
# Countries seed
    Category.delete_all
    open(Rails.root.join('lib', 'tasks', 'seeds', 'categories')) do |categories|
      categories.read.each_line do |category|
        name, name_fr, name_ar = category.chomp.split('|')
        Category.create!(:name => name, :name_fr => name_fr, :name_ar => name_ar )
      end
    end
  end
end