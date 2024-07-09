# == Schema Information
#
# Table name: screens
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Screen < ApplicationRecord
  # 関連
  has_many :sheets, dependent: :destroy
  has_many :schedules
end
