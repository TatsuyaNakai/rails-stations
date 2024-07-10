require 'rails_helper'

RSpec.describe 'Screen', type: :mdoel do
  describe '#validates' do
    let!(:toho) { FactoryBot.create(:theater) }
    let!(:aeon) { FactoryBot.create(:theater) }

    it 'は、番号が劇場ごとにユニークであれば有効であること' do
      toho_screen = FactoryBot.create(:screen, theater: toho)
      aeon_screen = FactoryBot.build(:screen, number: toho_screen.number, theater: aeon)

      expect(aeon_screen).to be_valid
    end

    it 'は、番号が劇場ごとにユニークでない状態であれば無効であること' do
      toho_screen1 = FactoryBot.create(:screen, theater: toho)
      toho_screen2 = FactoryBot.build(:screen, number: toho_screen1.number, theater: toho)

      toho_screen2.valid?
      expect(toho_screen2.errors[:number]).to include('はすでに存在します')
    end
  end

  describe 'class_methods' do
    describe '#set_max_number' do
      context '新規作成時' do
        before do
          @theater = FactoryBot.create(:theater)
          @screen = FactoryBot.build(:screen, theater: @theater)
        end
        context '#numberが存在しないとき' do
          it 'は、自動で最大値 + 1を割り当てること' do
            number = @theater.screens.maximum(:number).to_i

            @screen.save
            expect(@screen.number).to eq(number + 1)
          end
        end

        context '#numberが存在するとき' do
          it 'は、数値を割り当てないこと' do
            number = 100

            @screen.assign_attributes(number: number)
            @screen.save
            expect(@screen.number).to eq(number)
          end
        end
      end
    end
  end
end
