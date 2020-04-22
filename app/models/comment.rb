# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :tweet

  has_many :notices, dependent: :destroy


  scope :recent, -> { order(created_at: :desc) }

  validates :content, presence: true
end
