# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :tweet

  has_many :notices, dependent: :destroy


  default_scope -> { order(created_at: :desc) }

  validates :content, presence: true
end
