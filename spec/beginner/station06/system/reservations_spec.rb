require 'rails_helper'
require_relative '../system_helper'

RSpec.describe 'Reservations', type: :system do
  describe 'GET /movies/:id/schedules/:schedule_id/sheets' do
    before do
      user = FactoryBot.create(:user)
      sign_in user

      @movie = FactoryBot.create(:movie)
      @screen = FactoryBot.create(:screen)
      @schedule = FactoryBot.create(:schedule, movie: @movie, screen: @screen)
      Sheet.create_sheets_for_screen!(@screen)
    end

    it 'フォームに値が格納されていること' do
      sheet = Sheet.first
      visit new_movie_reservation_path(movie_id: @movie.id, sheet_id: sheet.id, schedule_id: @schedule.id, date: Date.today)
      html = page.html

      expect(html).to have_field('reservation[schedule_id]', type: 'hidden')
      expect(html).to have_field('reservation[sheet_id]', type: 'hidden')
      expect(html).to have_field('reservation[date]', type: 'hidden')
    end
  end
end
