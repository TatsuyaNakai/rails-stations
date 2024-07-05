# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#

image_url = 'https://picsum.photos/300/440'
Movie.create(
  [
    { name: 'Star Wars', year: 2024, image_url: image_url, is_showing: true },
    { name: 'Lord of the Rings', year: 2023, image_url: image_url, is_showing: true },
    { name: 'Back to the Future', year: 1985, image_url: image_url, is_showing: false }
  ]
)

%w[a b c].each do |row|
  rows = []
  5.times do |n|
    column = n + 1
    rows << { column: column, row: row }
  end
  Sheet.create(rows)
end

#   Character.create(name: 'Luke', movie: movies.first)
