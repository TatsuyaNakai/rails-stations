require 'rails_helper'

RSpec.describe Ranking, type: :model do
  let(:movie) { FactoryBot.create(:movie) }
  let(:ranking) { FactoryBot.build(:ranking, movie: movie) }

  describe 'validates' do
    it 'は、有効な属性を持っている場合、有効であること' do
      expect(ranking).to be_valid
    end

    it 'は、reservation_countが整数でない場合、無効であること' do
      ranking.reservation_count = 1.5
      expect(ranking).to_not be_valid
    end

    it 'は、reservation_countが0未満の場合、無効であること' do
      ranking.reservation_count = -1
      expect(ranking).to_not be_valid
    end
  end

  describe 'callback' do
    it 'は、新しいレコード作成時にdateが設定されること' do
      ranking.date = nil
      ranking.valid?
      expect(ranking.date).to eq(Date.today)
    end
  end

  describe 'class_method' do
    describe '.insert_daily_rankings!' do
      let!(:date) { Date.yesterday }
      let!(:user) { FactoryBot.create(:user) }
      let!(:theater) { FactoryBot.create(:theater) }
      let!(:screen1) { FactoryBot.create(:screen, theater: theater) }
      let!(:screen2) { FactoryBot.create(:screen, theater: theater) }
      let!(:sheet1) { FactoryBot.create(:sheet, column: 1, row: 'a', screen_id: screen1.id) }
      let!(:sheet2) { FactoryBot.create(:sheet, column: 1, row: 'a', screen_id: screen2.id) }

      let!(:movie1) { FactoryBot.create(:movie) }
      let!(:movie2) { FactoryBot.create(:movie) }
      let!(:schedule1) do
        FactoryBot.create(
          :schedule,
          screen_id: screen1.id,
          movie_id: movie1.id,
          start_time: date.to_time,
          end_time: date.to_time + 1.minutes
        )
      end
      let!(:schedule2) do
        FactoryBot.create(
          :schedule,
          screen_id: screen2.id,
          movie_id: movie2.id,
          start_time: date.to_time,
          end_time: date.to_time + 1.minutes
        )
      end

      it 'は、指定された日付のランクを挿入すること' do
        FactoryBot.create(:reservation, date: date, schedule_id: schedule1.id, sheet_id: sheet1.id, user_id: user.id)
        FactoryBot.create(:reservation, date: date, schedule_id: schedule2.id, sheet_id: sheet2.id, user_id: user.id)
        expect { Ranking.insert_daily_rankings!(date) }.to(change { Ranking.count }.by(2))
      end

      it 'は、既に日付が存在する場合、ランクを挿入しないこと' do
        FactoryBot.create(:ranking, movie: movie1, date: date)
        FactoryBot.create(:ranking, movie: movie2, date: date)
        expect { Ranking.insert_daily_rankings!(date) }.to_not(change { Ranking.count })
      end
    end
  end
end
