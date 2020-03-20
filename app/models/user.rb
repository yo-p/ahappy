class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attachment :profile_image #プロフィール画像

  validates :name, presence: true
  validates :introduction, length: { maximum: 50 } #自己紹介は50文字以内
end
