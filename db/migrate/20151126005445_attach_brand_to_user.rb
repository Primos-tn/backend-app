class AttachBrandToUser < ActiveRecord::Migration
  def change
    add_reference :brands, :account, index: true
    add_foreign_key :brands, :accounts
  end
end
