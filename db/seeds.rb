# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
  SEED_TABLE_NAMES = %w[product_discount_rules]

  SEED_TABLE_WITH_CLASS = [
  {file_name: 'products', klass: Product},
  {file_name: 'product_discount_rules', klass: ProductDiscountRule},
  {file_name: 'cart_discount_rules', klass: CartDiscountRule}
]

def csv_path(file_name)
  "db/csvs/#{file_name}.csv"
end

def sync!
  # SEED_TABLE_NAMES.each do |table_name|
  #   klass = Object.const_set(table_name.classify, Class.new(ActiveRecord::Base))
  #   sync_table!(klass, table_name)
  # end

  SEED_TABLE_WITH_CLASS.each do |record|
    sync_table!(record[:klass], record[:file_name])
  end
end

def sync_table!(klass, file_name)
  puts "Seeding #{file_name}"
  klass.transaction do
    CSV.foreach(csv_path(file_name), headers: true).each do |record|
      klass.where(record.to_hash).first_or_create
    end
  end
end

sync!

