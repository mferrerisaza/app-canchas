class RenamePhoneInUsers < ActiveRecord::Migration[5.1]
  def change
    rename_column :users, :phone, :telefono
    rename_column :users, :colombian_id, :identificacion
  end
end
