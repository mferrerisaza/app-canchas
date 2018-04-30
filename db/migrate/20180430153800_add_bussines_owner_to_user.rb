class AddBussinesOwnerToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :business_owner, :boolean
  end
end
