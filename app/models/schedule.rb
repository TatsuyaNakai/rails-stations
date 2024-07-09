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
#  screen_id                :bigint           not null
#
# Indexes
#
#  index_schedules_on_movie_id   (movie_id)
#  index_schedules_on_screen_id  (screen_id)
#
# Foreign Keys
#
#  fk_rails_...  (screen_id => screens.id)
#
class Schedule < ApplicationRecord
  # 関連
  belongs_to :movie
  has_many :reservations
  belongs_to :screen

  # バリデーション
  validate :check_show_time_overlap

  # メソッド(Private)
  def check_show_time_overlap
    show_time = start_time..end_time

    screen_schedules = Schedule.where(screen_id: screen_id)
    screen_schedules = screen_schedules.where(start_time: show_time, end_time: show_time)
    return if screen_schedules.empty?

    errors.add(:screen, 'は、上映時間中に他の作品を上映しています')
  end
end
