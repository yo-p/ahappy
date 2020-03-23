class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #プロフィール画像
  attachment :profile_image 

  validates :name, presence: true

  #自己紹介は50文字以内
  validates :introduction, length: { maximum: 50 } 

  has_many :tweets, dependent: :destroy
  has_many :comments, dependent: :destroy

  #has_many throurhオプションでuserがfavoした投稿を直接アソシエーションで取得 sorceで参照するモデルを指定
  has_many :favorites, dependent: :destroy
  has_many :favorited_tweet, through: :favorites, source: :tweet

  def already_favorited?(tweet)
    self.favorites.exists?(tweet_id: tweet.id)
  end
end
