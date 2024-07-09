# == Schema Information
#
# Table name: users
#
#  id                  :bigint           not null, primary key
#  email               :string(255)      default(""), not null
#  encrypted_password  :string(255)      default(""), not null
#  name                :string(255)
#  remember_created_at :datetime
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable, :recoverable and :omniauthable
  # モジュール
  devise :database_authenticatable, :registerable, :rememberable, :validatable

  # 関連
  has_many :reservations

  # バリデーション
  validates :email, presence: true,
                    length: { maximum: 255 },
                    email: true,
                    uniqueness: true

  validates :name, presence: true,
                   length: { maximum: 50 }

  validates :password_confirmation, presence: true, on: :create # Station14用
end
