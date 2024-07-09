# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#

screens = Screen.create([{}, {}, {}])

screens.each do |screen|
  %w[a b c].each do |row|
    rows = []
    5.times do |n|
      column = n + 1
      rows << { column: column, row: row }
    end
    screen.sheets.create(rows)
  end
end

image_url = 'https://picsum.photos/300/440'
Movie.create(
  [
    { name: 'Star Wars', year: '2024', image_url: image_url, is_showing: true },
    { name: 'Lord of the Rings', year: '2023', image_url: image_url, is_showing: true },
    { name: 'Back to the Future', year: '1985', image_url: image_url, is_showing: false }
  ]
)

def movie_schedules(date)
  movie_id = Movie.ids.sample
  [
    {
      movie_id: movie_id,
      start_time: Time.new(date.year, date.month, date.day, 8, 0, 0),
      end_time: Time.new(date.year, date.month, date.day, 9, 30, 0)
    }, {
      movie_id: movie_id,
      start_time: Time.new(date.year, date.month, date.day, 12, 30, 0),
      end_time: Time.new(date.year, date.month, date.day, 15, 0, 0)
    }, {
      movie_id: movie_id,
      start_time: Time.new(date.year, date.month, date.day, 17, 0, 0),
      end_time: Time.new(date.year, date.month, date.day, 18, 30, 0)
    }
  ]
end

dates = (-3..3).map { |i| Date.today + i }

screens.each do |screen|
  screen.schedules.create(dates.map { |date| movie_schedules(date) }.flatten)
end

#   Character.create(name: 'Luke', movie: movies.first)
