# frozen_string_literal: true

class Tweet < ApplicationRecord
  default_scope -> { order(created_at: :desc) }

  validates :title, presence: true
  validates :title, length: { maximum: 20 }
  
  validates :body, presence: true
  validates :body, length: { maximum: 50 }

  validates :genre_ids, presence: true
  validates :genre_ids, length: { maximum: 5 }

  attachment :image

  belongs_to :user

  has_many :comments, dependent: :destroy

  has_many :favorites, dependent: :destroy
  has_many :favarited_users, through: :favorites, source: :user

  has_many :tweet_genres, dependent: :destroy
  has_many :genres, through: :tweet_genres

  has_many :notices, dependent: :destroy


  # favoriteの通知機能
  def create_notice_favorite!(current_user)
    temp = Notice.where(["visitor_id = ? and visited_id = ? and tweet_id = ? and action = ?", current_user.id, user_id, id, 'favorite'])
    if temp.blank?
      notice = current_user.active_notices.new(
        tweet_id: id,
        visited_id: user_id,
        action: 'favorite'
      )

      if notice.visitor_id == notice.visited_id
          notice.checked = true
      end
      notice.save if notice.valid?
    end
  end

  #comment通知機能
  def create_notice_comment!(current_user, comment_id)
    temp_ids = Comment.where(tweet_id: id).where.not("user_id = ? or user_id = ?", 
                              current_user.id, user_id).select(:user_id).distinct
    temp_ids.each do |temp_id|
      save_notice_comment!(current_user, comment_id, temp_id['user_id'])
    end
    save_notice_comment!(current_user, comment_id, user_id)
  end

  def save_notice_comment!(current_user, comment_id, visited_id)
    notice = current_user.active_notices.new(
      tweet_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )

    if notice.visitor_id == notice.visited_id
      notice.checked = true
    end
    notice.save if notice.valid?
  end

end
