# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attachment :profile_image

  validates :name, presence: true
  validates :name, length: { maximum: 10 }
  validates :introduction, length: { maximum: 50 }

  has_many :tweets, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :favorites, dependent: :destroy
  has_many :favorited_tweet, through: :favorites, source: :tweet

  has_many :active_notices, foreign_key: "visitor_id", class_name: "Notice", dependent: :destroy
  has_many :passive_notices, foreign_key: "visited_id", class_name: "Notice", dependent: :destroy

  # すでにお気に入りしているか
  def already_favorited?(tweet)
    favorites.exists?(tweet_id: tweet.id)
  end
end
