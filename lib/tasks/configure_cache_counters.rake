=begin
  This is contains all recovery cache files
=end
namespace :configure do
  desc "Configuring services offer"
  task cache_counters: :environment do
    Brand.all.each do |brand|
      brand.products_count = brand.products.count
      brand.save
    end
  end
end