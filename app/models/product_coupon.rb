class ProductCoupon < ActiveRecord::Base

  belongs_to :product, counter_cache: :coupons_counts

  validates_uniqueness_of :value, scope: :product_id
  validates_presence_of :value
  validates_presence_of :product


  before_save :assign_image_qr_code

  ### mount uploader
  mount_uploader :image_qr_code, ProductCouponImage

  # 上面这两行代码换位置就不行了，为啥？
  private
  def assign_image_qr_code
    if self.image_qr_code.url == nil
      tmp_path = Rails.root.join('tmp', "qrcode.png")
      png = RQRCode::QRCode.new( value, :size => 4, :level => :h ).as_png(color: '#FFB249').resize(250, 250).save(tmp_path)
      File.open(tmp_path) do |file|
        self.image_qr_code = file
      end
      File.delete(tmp_path)
    end
  end



  #
  # def create_image_qr_code
  #   qrcode = RQRCode::QRCode.new("http://localhost:3000/dashboard/products/2/coupons")
  #   # With default options specified explicitly
  #   png = qrcode.as_png(
  #       resize_gte_to: false,
  #       resize_exactly_to: false,
  #       fill: 'white',
  #       color: 'black',
  #       size: 120,
  #       border_modules: 4,
  #       module_px_size: 6,
  #       file: nil # path to write
  #   )
  #
  # end

end
