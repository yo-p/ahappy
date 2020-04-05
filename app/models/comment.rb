# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :tweet

  default_scope -> { order(created_at: :desc) }

  validates :content, presence: true
end
