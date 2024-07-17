require 'rails_helper'

RSpec.describe Schedule, type: :model do
  let(:movie) { FactoryBot.create(:movie) }
  let(:screen) { FactoryBot.create(:screen) }
  let(:schedule) { FactoryBot.build(:schedule, movie: movie, screen: screen) }

  describe 'validate' do
    it 'は、有効な属性を持っている場合、有効であること' do
      expect(schedule).to be_valid
    end

    it 'は、上映時間が重複する場合、無効であること' do
      FactoryBot.create(:schedule, screen: screen, start_time: schedule.start_time, end_time: schedule.end_time)
      expect(schedule).to_not be_valid
      expect(schedule.errors[:screen]).to include('は、上映時間中に他の作品を上映しています')
    end
  end
end
