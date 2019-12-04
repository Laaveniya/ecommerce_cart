# frozen_string_literal: true

SEED_TABLE_WITH_CLASS = [
  { file_name: 'products', klass: Product },
  { file_name: 'product_discount_rules', klass: ProductDiscountRule },
  { file_name: 'cart_discount_rules', klass: CartDiscountRule }
].freeze

def csv_path(file_name)
  "db/csvs/#{file_name}.csv"
end

def sync!
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
