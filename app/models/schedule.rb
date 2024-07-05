# == Schema Information
#
# Table name: schedules
#
#  id                       :bigint           not null, primary key
#  end_time(上映終了時刻)   :datetime         not null
#  start_time(上映開始時刻) :datetime         not null
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  movie_id                 :bigint           not null
#
# Indexes
#
#  index_schedules_on_movie_id  (movie_id)
#
class Schedule < ApplicationRecord
  # 関連
  belongs_to :movie
end
