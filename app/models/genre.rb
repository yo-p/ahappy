class Genre < ApplicationRecord
    #tweet_genres中間テーブルを経由
    has_many :tweet_genres, dependent: :destroy
    # has_many :tweet_genres, dependent: :destroy, foreign_key:"tweet_id"
    has_many :tweets, through: :tweet_genres

    self.inheritance_column = :_type_disabled

    
end
