# == Schema Information
#
# Table name: theaters
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Theater < ApplicationRecord
  # 関連
  has_many :screens, dependent: :destroy
end
