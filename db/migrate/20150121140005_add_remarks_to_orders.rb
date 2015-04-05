class AddRemarksToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :remark, :text
  end
end
