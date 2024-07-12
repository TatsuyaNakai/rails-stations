require 'rails_helper'
require_relative '../../system_helper'

RSpec.describe 'Admin::Movies', type: :system do
  describe 'GET /admin/movies' do
    it 'は、テーブルの件数分、データが表示されていること' do
      movie1 = FactoryBot.create(:movie)
      movie2 = FactoryBot.create(:movie)

      visit admin_movies_path
      expect(page).to have_content(movie1.name)
      expect(page).to have_content(movie2.name)
    end

    it 'は、HTMLに全てのカラムが表示されていること' do
      movie = FactoryBot.create(:movie)

      visit admin_movies_path
      img = find('img')
      expect(page).to have_content(movie.id)
      expect(page).to have_content(movie.name)
      expect(page).to have_content(movie.year)
      expect(page).to have_content(movie.description)
      expect(img[:src]).to eq(movie.image_url)
      expect(page).to have_content(movie.is_showing ? '上映中' : '上映予定')
      expect(page).to have_content(movie.created_at)
      expect(page).to have_content(movie.updated_at)
    end

    it 'は、HTMLにtrue/false、もしくは1/0が表示されていないこと' do
      FactoryBot.create(:movie)

      visit admin_movies_path
      html = page.html
      expect(html).not_to include('true')
      expect(html).not_to include('false')
    end

    it 'は、tableタグが存在すること' do
      visit admin_movies_path

      expect(page.html).to have_selector('table')
    end
  end

  describe 'GET /admin/movies/new' do
    it 'は、formタグが存在すること' do
      visit new_admin_movie_path

      expect(page.html).to have_selector('form')
    end
  end
end
