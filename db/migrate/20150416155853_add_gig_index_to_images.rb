class AddGigIndexToImages < ActiveRecord::Migration
  def change
  	add_index :images, :gig_id
  end
end
