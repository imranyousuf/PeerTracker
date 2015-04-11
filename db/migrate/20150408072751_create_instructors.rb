class CreateInstructors < ActiveRecord::Migration
  def change
    create_table :instructors do |t|
      t.text :name
      t.text :sid
      t.text :email
      t.text :teams

      t.timestamps null: false
    end
  end
end
