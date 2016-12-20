namespace :products do


  namespace :pictures do
    desc "Business system configuration"
    task change_file_names: :environment do
       Product.all.each do |entry|
         entry.pictures.each do |picture|
           picture.recreate_versions!
         end
         entry.save!
       end
    end
  end


end