class AddColumnsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :name, :string
    add_column :users, :username, :string
    add_column :users, :introduction, :text
    add_column :users, :website, :string
    add_column :users, :phone_number, :string
    add_column :users, :sex, :string
    add_column :users, :provider, :string
    add_column :users, :uid, :string
  end
end
