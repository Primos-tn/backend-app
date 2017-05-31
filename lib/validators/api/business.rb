module Validators::Api::Business

  class Product
    include ActiveModel::Validations

    attr_accessor :name, :new_price, :old_price, :pictures

    validates :old_price, presence: true, numericality: true
    validates :new_price, presence: true, numericality: true
    validates :name, presence: true

    def initialize(params={})
      @name = params[:name]
      @new_price = params[:new_price]
      @old_price = params[:old_price]
      ActionController::Parameters.new(params).permit(:name, :old_price, :longitude)
    end
  end

end