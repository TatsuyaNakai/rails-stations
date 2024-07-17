require 'rails_helper'

RSpec.describe Screen, type: :model do
  let(:theater) { FactoryBot.create(:theater) }
  let(:screen) { FactoryBot.build(:screen, theater: theater) }

  describe 'validate' do
    it 'は、有効な属性を持っている場合、有効であること' do
      expect(screen).to be_valid
    end

    it 'は、numberが整数でない場合、無効であること' do
      screen.number = 1.5
      expect(screen).to_not be_valid
    end
  end

  describe 'callback' do
    it 'は、新しいレコード作成時にnumberが設定されること' do
      screen.number = nil
      screen.valid?
      expect(screen.number).to eq(theater.screens.maximum(:number).to_i + 1)
    end
  end
end
