require 'rails_helper'

RSpec.describe Sheet, type: :model do
  let(:screen) { FactoryBot.create(:screen) }
  let(:sheet) { FactoryBot.build(:sheet, screen: screen) }

  describe 'validate' do
    it 'は、有効な属性を持っている場合、有効であること' do
      expect(sheet).to be_valid
    end

    it 'は、columnが整数でない場合、無効であること' do
      sheet.column = 'a'
      expect(sheet).to_not be_valid
    end

    it 'は、rowがない場合、無効であること' do
      sheet.row = nil
      expect(sheet).to_not be_valid
    end
  end

  describe 'class method' do
    describe '.create_sheets_for_screen!' do
      it 'は、screenにシートを作成すること' do
        expect { Sheet.create_sheets_for_screen!(screen) }.to(change { screen.sheets.count }.by(15))
      end

      it 'は、screenに既にシートが存在する場合、新しいシートを作成しないこと' do
        FactoryBot.create(:sheet, screen: screen)
        expect { Sheet.create_sheets_for_screen!(screen) }.to_not(change { screen.sheets.count })
      end
    end
  end

  describe 'method' do
    describe '#reserved?' do
      let(:schedule) { FactoryBot.create(:schedule, screen: screen) }
      let(:reservation) { FactoryBot.create(:reservation, sheet: sheet, schedule: schedule) }

      it 'は、指定されたschedule_idで予約されている場合、trueを返すこと' do
        reservation
        expect(sheet.reserved?(schedule.id)).to be true
      end

      it 'は、指定されたschedule_idで予約されていない場合、falseを返すこと' do
        expect(sheet.reserved?(schedule.id)).to be false
      end
    end

    describe '#position' do
      it 'は、シートの位置を返すこと' do
        expect(sheet.position).to eq("#{sheet.row.upcase}-#{sheet.column}")
      end
    end
  end
end
