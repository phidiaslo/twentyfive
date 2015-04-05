class AddViewCountToGigs < ActiveRecord::Migration
  def change
    add_column :gigs, :view_count, :integer, :default => 0, :null => false
  end
end
