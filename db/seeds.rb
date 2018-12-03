# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


gem 'json'
gem 'activerecord-import'


autofile = File.open('db/auto_parts.json').read
auto_hash = JSON.parse(autofile)

autoArray = []
columns_auto = [:field, :name]
auto_hash.each do |line|
  @typeIndex = line['field']
  line['elements'].each do |ele|
    autoArray << AutoPart.new(field:@typeIndex, name:ele)
  end
end



AutoPart.import columns_auto, autoArray
