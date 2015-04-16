class InitialDatabaseSchema < ActiveRecord::Migration
  def change
  	# COURSES table
  	create_table :courses do |t|
  	  t.string :course_name
  	  t.integer :user_id #Professor ID
    end

     # ASSIGNMENTS table
    create_table :assignments do |t|
      t.string :assignment_name
      t.integer :course_id
      t.timestamp :deadline
      t.timestamps null: false
    end
    add_foreign_key :assignments, :courses

     # CREDENTIALS table
    create_table :credentials do |t|
      t.integer :uid
      t.integer :course_id
    end
    add_foreign_key :credentials, :courses

     # FEEDBACK_GIVENS table
    create_table :feedback_givens do |t|
      t.text :comments
      t.integer :rating
      t.integer :user_id
      t.integer :assignment_id
      t.timestamps null: false
    end
    add_foreign_key :feedback_givens, :users
    add_foreign_key :feedback_givens, :assignments

    # FEEDBACK_RECEIVEDS table
    create_table :feedback_receiveds do |t|
      t.text :comments
      t.integer :rating
      t.integer :user_id
      t.integer :assignment_id
      t.timestamps null: false
    end
    add_foreign_key :feedback_receiveds, :users
    add_foreign_key :feedback_receiveds, :assignments

     #USERS/COURSES JOIN TABLE
    create_table :courses_users, id: false do |t|
    	t.belongs_to :course, index:true
    	t.belongs_to :user, index:true
    end

    create_table :teams do |t|
      t.string :name
      t.integer :course_id
    end
    add_foreign_key :teams, :courses

     #USERS/TEAMS JOIN TABLE
    create_table :teams_users, id: false do |t|
    	t.belongs_to :user, index: true
    	t.belongs_to :team, index:true
    end
  end
end
