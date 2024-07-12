# == Schema Information
#
# Table name: sheets
#
#  id         :bigint           not null, primary key
#  column     :integer          not null
#  row        :string(1)        not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  screen_id  :bigint           not null
#
# Indexes
#
#  index_sheets_on_screen_id  (screen_id)
#
# Foreign Keys
#
#  fk_rails_...  (screen_id => screens.id)
#
class Sheet < ApplicationRecord
  # 関連
  belongs_to :screen
  has_many :reservations

  # クラスメソッド
  def self.create_sheets_for_screen!(screen)
    return if screen.sheets.present?

    %w[a b c].each do |row|
      rows = []
      5.times do |n|
        column = n + 1
        rows << { column: column, row: row }
      end
      screen.sheets.create!(rows)
    end
  end

  # メソッド

  def reserved?(schedule_id)
    reservations.pluck(:schedule_id).include?(schedule_id.to_i)
  end

  def position
    "#{row.upcase}-#{column}"
  end
end
