class CreateFavorites < ActiveRecord::Migration[5.2]
  def change
    create_table :favorites do |t|
      t.references :user, foreign_key: true
      t.references :tweet, foreign_key: true
      
      #user_idとtweet_idが重複するのを防ぎ、同じ投稿に何度もお気に入りできなくするため
      t.index [:user_id, :tweet_id], unique: true
      t.timestamps
    end
  end
end
