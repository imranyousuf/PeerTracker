class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.text :name
      t.text :sid
      t.text :email
      t.text :instructor
      t.text :team

      t.timestamps null: false
    end
  end
end
