require 'rails_helper'
require_relative '../system_helper'

RSpec.describe 'Sheets', type: :system do
  describe 'GET /sheets' do
    it 'は、tableタグが存在すること' do
      visit sheets_path

      expect(page.html).to have_selector('table')
    end

    it 'は、Sheetsテーブルから取得していること' do
      # columnを標準でない数にして、参照していることを担保とした
      sheet = FactoryBot.create(:sheet, row: 'a', column: 100)
      visit sheets_path

      expect(page).to have_content(sheet.column)
    end
  end
end
