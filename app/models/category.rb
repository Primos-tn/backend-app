require 'csv'
class Category < ActiveRecord::Base
  has_many :categories, foreign_key: 'parent_id', dependent: :destroy
  belongs_to :category, foreign_key: 'parent_id'

  has_many :category_products, class_name: 'CategoryProduct'
  has_many :products, :through => :category_products

  validates_presence_of :name
  validates_presence_of :name_fr
  validates_presence_of :name_ar

  validates_uniqueness_of :name
  validates_uniqueness_of :name_fr
  validates_uniqueness_of :name_ar


  def self.children(parent_id)
    where({:parent_id => parent_id}).all
  end

  def self.children_recursive_ids(parents=[], old_ids=[])
    if parents.count > 0
      new_parents_ids = Category.where(parent_id: parents).all.map(&:id)
      old_ids += parents
      Category.children_recursive_ids(new_parents_ids, old_ids)
    else
      old_ids+parents
    end
  end

  def self.top_of_day_by_products(stores_ids = [])
    if stores_ids.length.equal?(0)
      return []
    end
    now = Time.now.utc.strftime('%H:%M:%S')
    categories_ids = ProductLaunch
                            .joins(product: [:stores, :categories])
                            .where({launch_date: Date.today})
                            .where('((end_at >= ? AND start_at <= ?) or (end_at is NULL))', now, now)
                            .where(stores_ids.nil? ? '' : "product_stores.store_id in (#{stores_ids.join(',')})")
                            .select('distinct on (categories_products.category_id) categories_products.category_id, categories.*')
                            .order('categories_products.category_id DESC')
                            .limit(10)
                            .pluck('categories_products.category_id')

    if categories_ids.length < 10
      categories_ids = categories_ids + Category
                                 .where
                                 .not({:id => categories_ids})
                                 .limit(10 - categories_ids.length)
                                 .pluck(:id)
    end

    Category.where({:id => categories_ids}).all
  end

  def self.top_brands_of_day(stores_ids)
    if stores_ids.length.equal?(0)
      return []
    end

    brands_id =Brand
                   .select(:category_id)
                   .distinct
                   .joins([:stores])
                   .where({:stores => {id: stores_ids}})
                   .order('category_id DESC')

    Category.find_by({:id => brands_id})

  end

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |item|
        csv << item.attributes.values
      end
    end
  end

end
