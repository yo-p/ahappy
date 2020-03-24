class CreateTweetGenres < ActiveRecord::Migration[5.2]
  def change
    create_table :tweet_genres do |t|
      t.references :tweet, foreign_key: true
      t.references :genre, foreign_key: true
      t.timestamps
    end
  end
end
