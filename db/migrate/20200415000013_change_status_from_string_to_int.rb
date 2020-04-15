class ChangeStatusFromStringToInt < ActiveRecord::Migration[5.1]
  def change
    remove_column :item_orders, :status
    add_column :item_orders, :status, :integer, default:0
  end
end
