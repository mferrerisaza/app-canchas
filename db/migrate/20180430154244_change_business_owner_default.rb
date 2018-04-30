class ChangeBusinessOwnerDefault < ActiveRecord::Migration[5.1]
  def change
    change_column_default :users, :business_owner, false
  end
end
