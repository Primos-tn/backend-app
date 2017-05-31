class TesterController < ApplicationController
  include StoresSearchable
  require 'whatlanguage'
  @@wl = WhatLanguage.new(:english, :arabic, :french)

  def index
    #render json: [@@wl.language(params[:text])]
    render json: MessengerController.instance.top_brands(0, [13])

  end


  def test_messenger
    render json: MessengerController.instance.get_categories(0, 'fr')
  end

  def top_brands_of_day
    render json: Category.top_brands_of_day(get_stores_near)
  end

  def top_of_day_by_products
    products = Category.top_of_day_by_products(get_stores_near).as_json
    puts products
    render json: products
  end
end