class TweetGenre < ApplicationRecord
    #genreとtweetの中間テーブル
    belongs_to :tweet
    belongs_to :genre
end
