class Addgroupnumbertoteams < ActiveRecord::Migration
  def change
    add_column :teams, :group_number, :integer
  end
end
