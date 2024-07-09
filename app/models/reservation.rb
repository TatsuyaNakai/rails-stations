# == Schema Information
#
# Table name: reservations
#
#  id          :bigint           not null, primary key
#  date        :date             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  schedule_id :bigint           not null
#  sheet_id    :bigint           not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_reservations_on_schedule_id               (schedule_id)
#  index_reservations_on_schedule_id_and_sheet_id  (schedule_id,sheet_id) UNIQUE
#  index_reservations_on_sheet_id                  (sheet_id)
#  index_reservations_on_user_id                   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Reservation < ApplicationRecord
  # 関連
  belongs_to :schedule
  belongs_to :sheet
  belongs_to :user

  # バリデーション
  validates :sheet, uniqueness: { scope: :schedule }

  validates :date, presence: true
end
