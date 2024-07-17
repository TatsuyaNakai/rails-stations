require 'rails_helper'
RSpec.describe Movie, type: :model do
  let(:movie) { FactoryBot.build(:movie) }

  describe 'validates' do
    it 'は、有効な属性を持っている場合、有効であること' do
      expect(movie).to be_valid
    end

    it 'は、名前がない場合、無効であること' do
      movie.name = nil
      expect(movie).to_not be_valid
    end

    it 'は、重複した名前がある場合、無効であること' do
      FactoryBot.create(:movie, name: movie.name)
      expect(movie).to_not be_valid
    end

    it 'は、名前が160文字を超える場合、無効であること' do
      movie.name = 'a' * 161
      expect(movie).to_not be_valid
    end

    it 'は、年が空白である場合、有効であること' do
      movie.year = ''
      expect(movie).to be_valid
    end

    it 'は、年が数値でない場合、無効であること' do
      movie.year = 'abcd'
      expect(movie).to_not be_valid
    end

    it 'は、年が255文字を超える場合、無効であること' do
      movie.year = '1' * 256
      expect(movie).to_not be_valid
    end

    it 'は、説明がnilである場合、有効であること' do
      movie.description = nil
      expect(movie).to be_valid
    end

    it 'は、説明が150文字を超える場合、無効であること' do
      movie.description = 'a' * 151
      expect(movie).to_not be_valid
    end

    it 'は、画像URLが空白である場合、有効であること' do
      movie.image_url = ''
      expect(movie).to be_valid
    end

    it 'は、is_showingがない場合、無効であること' do
      movie.is_showing = nil
      expect(movie).to_not be_valid
    end
  end
end
