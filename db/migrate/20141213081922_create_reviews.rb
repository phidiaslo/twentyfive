class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :gig_id
      t.integer :user_id
      t.string :subject
      t.text :body
      t.integer :communication_rating
      t.integer :service_rating
      t.integer :recommend_rating

      t.timestamps
    end
  end
end
