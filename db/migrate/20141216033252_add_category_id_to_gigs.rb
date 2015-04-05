class AddCategoryIdToGigs < ActiveRecord::Migration
  def change
    add_column :gigs, :category_id, :integer
  end
end
