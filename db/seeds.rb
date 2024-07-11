# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#

theaters = Theater.create([{}, {}])
theaters.each { |theater| theater.screens.create([{}]) }

screens = Screen.all
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
    { name: 'Star Wars', year: '2024', image_url: image_url, is_showing: true }
    # { name: 'Lord of the Rings', year: '2023', image_url: image_url, is_showing: true },
    # { name: 'Back to the Future', year: '1985', image_url: image_url, is_showing: true }
  ]
)

def movie_schedules(date)
  movie_id = Movie.first.id
  [
    {
      movie_id: movie_id,
      start_time: Time.new(date.year, date.month, date.day, 8, 0, 0),
      end_time: Time.new(date.year, date.month, date.day, 9, 30, 0)
    }
    # }, {
    #   movie_id: movie_id,
    #   start_time: Time.new(date.year, date.month, date.day, 17, 0, 0),
    #   end_time: Time.new(date.year, date.month, date.day, 18, 30, 0)
    # }
  ]
end

dates = (-5..6).map { |i| Date.today + i }

screens.each do |screen|
  screen.schedules.create(dates.map { |date| movie_schedules(date) }.flatten)
end

user = User.create!(name: 'User1', email: 'test@gmail.com', password: 'password')

Schedule.all.each do |schedule|
  date = schedule.end_time.to_date
  sheets = Sheet.where(screen_id: schedule.screen_id, row: 'a')
  num = (1..5).to_a.sample
  # num = 1 # レビュ実施時 => 全てのスクリーンにおいて、1座席だけ埋まる
  sheets.sample(num).each { |sheet| sheet.reservations.create!(user_id: user.id, date: date, schedule_id: schedule.id) }
end

(Date.today - 2.months..Date.yesterday).each { |date| Ranking.insert_daily_rankings!(date) }
