class AddImageQrCodeToProductCoupon < ActiveRecord::Migration[5.0]
  def change
    add_column :product_coupons, :image_qr_code,  :string
  end
end
