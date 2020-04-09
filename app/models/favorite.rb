# frozen_string_literal: true

class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :tweet

  default_scope -> { order(created_at: :desc) }
  
  validates :user_id, uniqueness: { scope: :tweet_id }
end
