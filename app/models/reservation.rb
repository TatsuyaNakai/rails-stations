# == Schema Information
#
# Table name: reservations
#
#  id                          :bigint           not null, primary key
#  date                        :date             not null
#  email(予約者メールアドレス) :string(255)      not null
#  name(予約者名)              :string(50)       not null
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  schedule_id                 :bigint           not null
#  sheet_id                    :bigint           not null
#
# Indexes
#
#  index_reservations_on_schedule_id               (schedule_id)
#  index_reservations_on_schedule_id_and_sheet_id  (schedule_id,sheet_id) UNIQUE
#  index_reservations_on_sheet_id                  (sheet_id)
#
class Reservation < ApplicationRecord
  # 関連
  belongs_to :schedule
  belongs_to :sheet

  # バリデーション
  validates :sheet, uniqueness: { scope: :schedule }

  validates :date, presence: true

  validates :email, presence: true,
                    length: { maximum: 255 },
                    email: true

  validates :name, presence: true,
                   length: { maximum: 50 }
end
