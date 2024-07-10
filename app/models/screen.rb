# == Schema Information
#
# Table name: screens
#
#  id         :bigint           not null, primary key
#  number     :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  theater_id :bigint           not null
#
# Indexes
#
#  index_screens_on_theater_id             (theater_id)
#  index_screens_on_theater_id_and_number  (theater_id,number) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (theater_id => theaters.id)
#
class Screen < ApplicationRecord
  # 関連
  belongs_to :theater
  has_many :sheets, dependent: :destroy
  has_many :schedules

  # フック
  before_validation :set_max_number, if: :new_record?, unless: :number?

  # バリデーション
  validates :number, numericality: { only_integer: true },
                     uniqueness: { scope: :theater }

  # メソッド(Private)

  def set_max_number
    self.number = theater.screens.maximum(:number).to_i + 1
  end
end
