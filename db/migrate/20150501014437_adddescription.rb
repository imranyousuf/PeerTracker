class Adddescription < ActiveRecord::Migration
  def change
    add_column :courses, :description, :text 
    add_column :assignments, :description, :text
  end
end
