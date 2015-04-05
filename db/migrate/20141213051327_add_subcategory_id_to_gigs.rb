class AddSubcategoryIdToGigs < ActiveRecord::Migration
  def change
    add_column :gigs, :subcategory_id, :integer
  end
end
