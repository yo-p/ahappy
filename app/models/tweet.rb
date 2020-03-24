class Tweet < ApplicationRecord
    #tweetの画像も投稿
    attachment :image 

    belongs_to :user 

    #開発途中ジャンル空でも投稿可能
    belongs_to :genre, optional: true
    
    has_many :comments, dependent: :destroy

    #favorite modelを経由してuserテーブルと繋げる
    has_many :favorites
    has_many :favarited_users, through: :favorites, source: :user 

    #tweetは複数のgenreに紐ずくためtweet_genres中間テーブルを作成
    has_many :tweet_genres
    has_many :genres, through: :tweet_genres

    validates :title, presence: true
    validates :body, presence: true
end
