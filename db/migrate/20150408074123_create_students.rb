class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.text :name
      t.text :email
      t.integer :quiz1
      t.integer :quiz2
      t.integer :quiz3
      t.text :overall

      t.timestamps null: false
    end
  end
end
