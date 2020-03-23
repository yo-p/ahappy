class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :tweet

  #モデルレベルで一意性（ユニーク）を保つ
  validates :user_id, uniqueness: {scope: :tweet_id} 
end
