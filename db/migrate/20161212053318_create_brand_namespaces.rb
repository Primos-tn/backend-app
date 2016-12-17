class CreateBrandNamespaces < ActiveRecord::Migration[5.0]
  def change
    create_table :brand_namespaces do |t|
      t.integer :account_id
      t.integer :brand_id
      t.datetime :expires_at

      t.timestamps
    end
  end
end
