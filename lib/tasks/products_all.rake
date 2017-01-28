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
    BrandGallery.all.each do |entry|
      ImageProcessing.perform_now entry
    end
    puts 'End generating dominants colors '
  end

end