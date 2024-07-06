# == Schema Information
#
# Table name: movies
#
#  id                                                 :bigint           not null, primary key
#  description(映画の説明文)                          :text(65535)
#  image_url(映画のポスター画像が格納されているURL)   :string(150)
#  is_showing(上映中かどうか)                         :boolean          default(TRUE), not null
#  name(映画のタイトル。邦題・洋題は一旦考えなくてOK) :string(160)      not null
#  year(公開年)                                       :integer
#  created_at                                         :datetime         not null
#  updated_at                                         :datetime         not null
#
# Indexes
#
#  index_movies_on_name  (name)
#
class Movie < ApplicationRecord
  # 関連
  has_many :schedules, dependent: :destroy

  # フック
  # before_destroy :check_is_showing_false

  # バリデーション
  validates :name, presence: true,
                   uniqueness: true,
                   length: { maximum: 160 }

  validates :year, allow_blank: true,
                   length: { maximum: 255 },
                   format: { with: /\A\d+\z/ }

  validates :description, allow_blank: true,
                          length: { maximum: 800 }

  validates :description, allow_nil: true,
                          length: { maximum: 150 }

  validates :image_url, allow_blank: true,
                        url: true

  validates :is_showing, inclusion: [true, false]

  # メソッド(Private)

  # private

  # Part5の要件に入っているが不要？
  # def check_is_showing_false
  #   errors.add(:base, '上映中の作品は削除できません') if is_showing?

  #   throw :abort unless errors.empty?
  # end
end