class AddStatusToCashouts < ActiveRecord::Migration
  def change
    add_column :cashouts, :status, :string
  end
end
