class Movie < ApplicationRecord
  # バリデーション
  validates :name, presence: true,
                   length: { maximum: 160 }

  validates :year, allow_blank: true,
                   numericality: { only_integer: true },
                   inclusion: { in: 1..10_000 }

  validates :description, allow_blank: true,
                          length: { maximum: 800 }

  validates :description, allow_nil: true,
                          length: { maximum: 150 }

  validates :image_url, allow_blank: true,
                        url: true

  validates :is_showing, inclusion: [true, false]
end
