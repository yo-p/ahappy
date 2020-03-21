class Tweet < ApplicationRecord
    attachment :image #tweetに画像も投稿
    belongs_to :user 
    belongs_to :genre, optional: true #開発途中ジャンル空でも投稿可能 

    validates :title, presence: true
    validates :body, presence: true
end
