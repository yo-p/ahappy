# frozen_string_literal: true

class Genre < ApplicationRecord
  
  has_many :tweet_genres, dependent: :destroy
  has_many :tweets, through: :tweet_genres

  self.inheritance_column = :_type_disabled
end
