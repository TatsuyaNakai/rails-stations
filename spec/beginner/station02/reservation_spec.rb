require 'rails_helper'

RSpec.describe 'Reservation', type: :mdoel do
  # 既存のFactoryBotの定義を変更したくないので、一部のレコードについてはFactoryBotを使用しない
  describe '#validates' do
    let(:user) { FactoryBot.create(:user) }
    let(:screen) { FactoryBot.create(:screen) }
    let(:movie) { FactoryBot.create(:movie) }
    let(:sheet) { Sheet.create(column: 'a', row: 1, screen_id: screen.id) }
    let(:schedule) { Schedule.create(screen_id: screen.id, movie_id: movie.id, start_time: Time.current, end_time: Time.current + 1.minutes) }

    it '同一スケジュールでの同じシートで予約ができないこと' do
      reservation = Reservation.create(user_id: user.id, sheet_id: sheet.id, schedule_id: schedule.id, date: Date.today)
      dup = reservation.dup

      dup.valid?
      expect(dup.errors[:sheet]).to include('はすでに存在します')
    end
  end
end
