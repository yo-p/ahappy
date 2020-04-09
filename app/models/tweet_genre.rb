# frozen_string_literal: true

class TweetGenre < ApplicationRecord
  belongs_to :tweet
  belongs_to :genre
end
