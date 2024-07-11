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

  describe '.total_reservations_by_movie' do
    before do
      Reservation.create!(date: date, schedule_id: schedule1.id, sheet_id: sheet1.id, user_id: user.id)
      Reservation.create!(date: date, schedule_id: schedule2.id, sheet_id: sheet2.id, user_id: user.id)
      Ranking.insert_daily_rankings!(date)
    end

    context 'date_range = nil のとき' do
      it 'は、集計できること' do
        expect(Ranking.total_reservations_by_movie.first.movie_id).to eq(movie1.id)
        expect(Ranking.total_reservations_by_movie.first.total_reservations).to eq(1)
      end
    end

    context 'date_range = Date のとき' do
      it 'は、範囲を限定して集計できること' do
        tommorow = Date.tomorrow
        expect(Ranking.total_reservations_by_movie(tommorow)).to eq([])
      end
    end
  end
end
