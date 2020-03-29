class Tweet < ApplicationRecord
    #genre_idを配列で保存
    # serialize :genre_id

    # tweetを新着順に表示
    default_scope -> {order(created_at: :desc)}

    #tweetの画像も投稿可能
    attachment :image 

    belongs_to :user 

    #dependent: :destroyをつける事でtweetに紐ずくcommentsも削除
    has_many :comments, dependent: :destroy

    #favorite modelを経由してuserテーブルと繋げる
    #dependent: :destroyをつける事でtweetに紐ずくfavoritesも削除
    has_many :favorites, dependent: :destroy
    has_many :favarited_users, through: :favorites, source: :user 

    #tweetは複数のgenreに紐ずくためtweet_genres中間テーブルを作成
    #dependent: :destroyをつける事でtweetに紐ずくtweet_genresも削除
    has_many :tweet_genres, dependent: :destroy
    has_many :genres, through: :tweet_genres

    validates :title, presence: true
    validates :body, presence: true
    validates :genre_ids, presence: true

    
end
