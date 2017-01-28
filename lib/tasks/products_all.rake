require 'open3'
namespace :products do

end
namespace :gallery do
  desc 'Products pictures name'

  task change_file_names: :environment do
    Product.all.each do |entry|
      entry.pictures.each do |picture|
        picture.recreate_versions!
      end
      entry.save!
    end
  end

  desc 'Products pictures name'
  task set_dominant_colors: :environment do
    puts 'Staring generating dominants colors '
    ImageProcessing.perform_now BrandGallery.find(112)

    puts 'End generating dominants colors '
  end

end