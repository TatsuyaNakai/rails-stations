require 'rails_helper'

RSpec.describe Reservation, type: :model do
  context '上映スケジュールが同じ、かつシートが同じ場合' do
    let!(:reservation) { FactoryBot.create(:reservation) }

    it 'は、保存できないこと' do
      obj = reservation.dup
      obj.valid?
      expect(obj.errors[:sheet]).to include('はすでに存在します')
    end
  end
end
