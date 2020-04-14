class AddEnabledToMerchant < ActiveRecord::Migration[5.1]
  def change
    add_column :merchants, :enabled?, :integer, default:0
  end
end
