class AddOmniauthToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :provider, :string
    add_column :users, :uid, :string
    add_column :first_name, :string
    add_column :last_name, :string
    add_column :token, :string
    add_column :token_expiracy :datetime
  end
end
