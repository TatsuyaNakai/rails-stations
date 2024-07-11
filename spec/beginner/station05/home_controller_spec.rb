require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  let(:yesterday) { Date.yesterday }
  let(:user) { create(:user) }
  let(:screen1) { FactoryBot.create(:screen) }
  let(:screen2) { FactoryBot.create(:screen) }
  let(:movie1) { create(:movie) }
  let(:movie2) { create(:movie) }
  let(:schedule1) do
    Schedule.create(
      screen_id: screen1.id,
      movie_id: movie1.id,
      start_time: yesterday.to_datetime,
      end_time: yesterday.to_datetime + 1.minutes
    )
  end
  let(:schedule2) do
    Schedule.create(
      screen_id: screen2.id,
      movie_id: movie2.id,
      start_time: yesterday.to_datetime,
      end_time: yesterday.to_datetime + 1.minutes
    )
  end
  let(:sheet1) { Sheet.create(column: 'a', row: 1, screen_id: screen1.id) }
  let(:sheet2) { Sheet.create(column: 'a', row: 1, screen_id: screen2.id) }

  before do
    Reservation.create(date: yesterday, schedule_id: schedule1.id, sheet_id: sheet1.id, user_id: user.id)
    Reservation.create(date: yesterday, schedule_id: schedule2.id, sheet_id: sheet2.id, user_id: user.id)

    Ranking.insert_daily_rankings!(yesterday)
  end

  describe 'GET #index' do
    it 'は、date_range 内の映画ごとの予約総数を@ranking_countに割り当てること' do
      get :index
      date_range = Date.today.ago(30.days)..Date.yesterday

      expected_ranking = Ranking.total_reservations_by_movie(date_range)
      expect(assigns(:ranking_count)).to eq(expected_ranking)
    end
  end
end
