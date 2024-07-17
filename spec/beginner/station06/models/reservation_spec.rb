require 'rails_helper'

RSpec.describe Reservation, type: :model do
  let(:schedule) { FactoryBot.create(:schedule) }
  let(:sheet) { FactoryBot.create(:sheet, screen: schedule.screen) }
  let(:user) { FactoryBot.create(:user) }
  let(:reservation) { FactoryBot.build(:reservation, schedule: schedule, sheet: sheet, user: user) }

  describe 'バリデーション' do
    it 'は、有効な属性を持っている場合、有効であること' do
      expect(reservation).to be_valid
    end

    it 'は、同じスケジュールに対してシートが重複する場合、無効であること' do
      FactoryBot.create(:reservation, schedule: schedule, sheet: sheet)
      expect(reservation).to_not be_valid
    end

    it 'は、dateがない場合、無効であること' do
      reservation.date = nil
      expect(reservation).to_not be_valid
    end
  end
end
