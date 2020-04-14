class ChangeColumninMerchant < ActiveRecord::Migration[5.1]
  def change
    remove_column :merchants, :enabled?
    add_column :merchants, :enabled?, :boolean, default:true
  end
end
