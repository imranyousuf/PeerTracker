class Addgroupnumbertoteams < ActiveRecord::Migration
  def change
	change_column :teams, :group_number, :integer
  end
end
