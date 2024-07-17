# == Schema Information
#
# Table name: rankings
#
#  id                :bigint           not null, primary key
#  date              :date             not null
#  reservation_count :integer          not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  movie_id          :bigint           not null
#
# Indexes
#
#  index_rankings_on_movie_id  (movie_id)
#
class Ranking < ApplicationRecord
  # 関連
  belongs_to :movie

  # フック
  before_validation :set_date, if: :new_record?, unless: :date?

  # バリデーション
  validates :reservation_count, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  validates :date, presence: true

  # クラスメソッド
  def self.insert_daily_rankings!(date = Date.yesterday)
    now = Time.current
    timestamps = { created_at: now, updated_at: now }

    attrs = Movie.where(is_showing: true).map do |movie|
      reservation_count = movie.reservations.where(date: date).count
      { movie_id: movie.id, reservation_count: reservation_count, date: date, **timestamps }
    end
    # 既にランキングが作成されている場合は、実施しない
    Ranking.insert_all!(attrs) unless Ranking.where(date: date).present?
  end

  # メソッド(Private)
  private

  def set_date
    self.date = Date.today
  end
end
