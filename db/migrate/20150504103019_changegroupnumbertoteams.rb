class Changegroupnumbertoteams < ActiveRecord::Migration
  def change
  	change_column :teams, :group_number, :integer, default: 0
  end
end
