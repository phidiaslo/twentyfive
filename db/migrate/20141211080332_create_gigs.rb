class CreateGigs < ActiveRecord::Migration
  def change
    create_table :gigs do |t|
      t.string :gig_title
      t.string :category
      t.text :description
      t.integer :duration
      t.text :video

      t.timestamps
    end
  end
end
