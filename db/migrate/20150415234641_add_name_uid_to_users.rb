class AddNameUidToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :uid, :integer
  end
end
