# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# categories = Category.create([{ name: 'Kids' }, { name: 'Food' }])

categories = Category.create({ name: 'Drinks' , parent_id: 2 })
print (Category.find(2).categories.count())