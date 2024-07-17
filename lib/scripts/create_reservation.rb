# 面談用
# 前日分の予約が作成されることを確認します。
# 既に前日のデータが作成されている場合には、先日のRankingを削除しています。
# そして、クーロンの実行(3分後)を待ちます。

puts '1. ---------------------'
puts '定期実行で既に前日のRakingがある場合はレコードが新たにされない為、前日のRankingを削除します。'
puts ''
yesterday = Date.yesterday
Ranking.where(date: yesterday).delete_all
puts "前日のRankingは#{Ranking.where(date: yesterday).count}件です。"
puts '------------------------'

puts '2. ---------------------'
puts '前日の予約を全て削除します。'
puts ''
Reservation.where(date: yesterday).delete_all
puts "前日のReservationは#{Reservation.where(date: yesterday).count}件です。"
puts '------------------------'

puts '3. ---------------------'
puts 'シアター1の1番スクリーンにおける、a-1のシートを予約します。'
puts '前日のスケジュールのいずれか(スケジュールは1日に1回しか上映しません)を予約します。'
puts ''
start_time = Time.new(yesterday.year, yesterday.month, yesterday.day, 8, 0, 0)
schedule = Schedule.find_by(start_time: start_time)
sheet = Sheet.find_by(screen_id: schedule.screen_id)
user = User.first
if schedule.reservations.create!(sheet_id: sheet.id, date: yesterday, user_id: user.id)
  puts '前日分の予約が作成されました。'
  puts "前日のReservationは#{Reservation.where(date: yesterday).count}件です。"
else
  puts '前日分の予約が作成されませんでした。'
end
puts '------------------------'

puts 'クーロンの実行(3分後)をお待ちください。'
