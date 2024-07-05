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
end
