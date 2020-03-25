class Genre < ApplicationRecord
    #tweet_genres中間テーブルを経由
    has_many :tweet_genres
    has_many :tweets, through: :tweet_genres

    self.inheritance_column = :_type_disabled

    
end
