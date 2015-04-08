class CreateTeachers < ActiveRecord::Migration
  def change
    create_table :teachers do |t|
      t.text :name
      t.text :email
      t.text :score

      t.timestamps null: false
    end
  end
end
