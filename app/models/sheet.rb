# == Schema Information
#
# Table name: sheets
#
#  id         :bigint           not null, primary key
#  column     :integer          not null
#  row        :string(1)        not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Sheet < ApplicationRecord
  # 関連
  has_many :reservations

  # メソッド

  def reserved?(schedule_id)
    reservations.pluck(:schedule_id).include?(schedule_id.to_i)
  end
end
