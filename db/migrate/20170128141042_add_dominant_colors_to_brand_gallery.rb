class AddDominantColorsToBrandGallery < ActiveRecord::Migration[5.0]
  def change
    add_column :brand_galleries, :dominant_colors, :string, array:true, default: []
  end
end
