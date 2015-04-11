class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.string :assignment_name
      t.string :course
      t.timestamp :deadline

      t.timestamps null: false
    end
  end
end
