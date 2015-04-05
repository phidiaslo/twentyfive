class AddSlugToGigs < ActiveRecord::Migration
  def change
    add_column :gigs, :slug, :string
    add_index :gigs, :slug, unique: true
  end
end
