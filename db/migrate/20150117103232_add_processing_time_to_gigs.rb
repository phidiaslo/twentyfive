class AddProcessingTimeToGigs < ActiveRecord::Migration
  def change
    add_column :gigs, :processing_time, :string
  end
end
