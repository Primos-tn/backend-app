class CreateUserBrandFollowingRelationships < ActiveRecord::Migration
  def change
    create_table :user_brand_following_relationships do |t|
      t.references :account, index: true, foreign_key: true
      t.references :brand, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
