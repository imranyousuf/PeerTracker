class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.text :comments
      t.float :ratings

      t.timestamps null: false
    end
  end
end
