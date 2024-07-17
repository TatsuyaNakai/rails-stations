require 'rails_helper'

RSpec.describe Ranking, type: :model do
  let!(:date) { Date.yesterday }
  let!(:user) { create(:user) }
  let!(:theater) { create(:theater) }
  let!(:screen1) { create(:screen, theater: theater) }
  let!(:screen2) { create(:screen, theater: theater) }
  let!(:sheet1) { Sheet.create(column: 'a', row: 1, screen_id: screen1.id) }
  let!(:sheet2) { Sheet.create(column: 'a', row: 1, screen_id: screen2.id) }

  let!(:movie1) { create(:movie) }
  let!(:movie2) { create(:movie) }
  let!(:schedule1) do
    Schedule.create(
      screen_id: screen1.id,
      movie_id: movie1.id,
      start_time: date.to_time,
      end_time: date.to_time + 1.minutes
    )
  end
  let!(:schedule2) do
    Schedule.create(
      screen_id: screen2.id,
      movie_id: movie2.id,
      start_time: date.to_time,
      end_time: date.to_time + 1.minutes
    )
  end

  describe '.insert_daily_rankings!' do
    it 'は、作品ごとの予約数を1日単位で集計すること' do
      Reservation.create(date: date, schedule_id: schedule1.id, sheet_id: sheet1.id, user_id: user.id)
      Reservation.create(date: date, schedule_id: schedule2.id, sheet_id: sheet2.id, user_id: user.id)

      expect { Ranking.insert_daily_rankings!(date) }.to change { Ranking.count }.by(2)
      expect(Ranking.last.date).to eq(date)
    end
  end
end
