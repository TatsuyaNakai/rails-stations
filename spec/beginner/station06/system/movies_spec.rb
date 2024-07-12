require 'rails_helper'
require_relative '../system_helper'
require_relative '../custom_helper'

RSpec.describe 'Movies', type: :system do
  describe 'GET /movies' do
    it 'は、テーブルの件数分、タイトルと画像が表示されていること' do
      movie1 = FactoryBot.create(:movie)
      movie2 = FactoryBot.create(:movie)

      visit movies_path
      expect(page).to have_content(movie1.name)
      expect(page).to have_content(movie2.name)

      within('.card', text: movie1.name) do
        img = find('img.card-img-top')
        expect(img[:src]).to eq(movie1.image_url)
      end

      within('.card', text: movie2.name) do
        img = find('img.card-img-top')
        expect(img[:src]).to eq(movie2.image_url)
      end
    end
  end
end
