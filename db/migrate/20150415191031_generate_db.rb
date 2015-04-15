class GenerateDb < ActiveRecord::Migration
  def change
  	# ADMINS table
  	create_table :admins do |t|
  	  t.string :last_name
  	  t.string :first_name
  	  t.integer :uid
  	  t.timestamps null: false
  	end

  	# ASSIGNMENTS table
  	create_table :assignments do |t|
      t.string :assignment_name
      t.integer :course_id
      t.timestamp :deadline
      t.timestamps null: false
    end
    add_foreign_key :assignments, :courses

    # COURSES table
    create_table :courses do |t|
  	  t.string :course_name
  	  t.integer :professor_id
    end
    add_foreign_key :courses, :professors

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
      t.integer :student_id
      t.integer :assignment_id
      t.timestamps null: false
    end
    add_foreign_key :feedback_givens, :students
    add_foreign_key :feedback_givens, :assignments

    # FEEDBACK_RECEIVEDS table
    create_table :feedback_receiveds do |t|
      t.text :comments
      t.integer :rating
      t.integer :student_id
      t.integer :assignment_id
      t.timestamps null: false
    end
    add_foreign_key :feedback_receiveds, :students
    add_foreign_key :feedback_receiveds, :assignments

    # INSTRUCTORS table
    create_table :instructors do |t|
      t.string :name 
      t.integer :sid 
      t.string :email
      t.integer :course_id
      t.timestamps null: false
    end
    add_foreign_key :instructors, :courses

    # STUDENTS table
    create_table :students do |t|
      t.string :name
      t.integer :sid
      t.string :email
      t.timestamps null: false
    end

    # TEAMS table
    create_table :teams do |t|
      t.string :name
      t.integer :course_id
      t.integer :instructor_id
    end
    add_foreign_key :teams, :courses
    add_foreign_key :teams, :instructors

    # STUDENTS/COURSES JOIN TABLE
    create_table :courses_students, id: false do |t|
      t.belongs_to :course, index: true
      t.belongs_to :student, index: true
    end

    # STUDENTS/TEAMS JOIN TABLE
    create_table :students_teams, id: false do |t|
      t.belongs_to :student, index: true
      t.belongs_to :team, index: true
    end

  end
end
