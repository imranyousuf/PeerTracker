# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#


#Creating Student Users
@a = User.create! :first_name => 'Diane', :last_name => 'Jones', :email => 'a@test.com', :password => 'apassword', :password_confirmation => 'apassword', :user_id => '10000000'
@b = User.create! :first_name => 'Nick', :last_name => 'Lee', :email => 'b@test.com', :password => 'bpassword', :password_confirmation => 'bpassword', :user_id => '10000001'
@c = User.create! :first_name => 'Jonathan', :last_name => 'Kim', :email => 'c@test.com', :password => 'cpassword', :password_confirmation => 'cpassword', :user_id => '10000002'
@d = User.create! :first_name => 'Tony', :last_name => 'Allen', :email => 'd@test.com', :password => 'dpassword', :password_confirmation => 'dpassword', :user_id => '10000003'
@e = User.create! :first_name => 'Drew', :last_name => 'Kim', :email => 'e@test.com', :password => 'epassword', :password_confirmation => 'epassword', :user_id => '10000004'
@f = User.create! :first_name => 'Nancy', :last_name => 'Park', :email => 'f@test.com', :password => 'fpassword', :password_confirmation => 'fpassword', :user_id => '10000005'
@g = User.create! :first_name => 'Stephen', :last_name => 'Curry', :email => 'g@test.com', :password => 'gpassword', :password_confirmation => 'gpassword', :user_id => '10000006'
@h = User.create! :first_name => 'Draymond', :last_name => 'Green', :email => 'h@test.com', :password => 'hpassword', :password_confirmation => 'hpassword', :user_id => '10000007'
@i = User.create! :first_name => 'Klay', :last_name => 'Thompson', :email => 'i@test.com', :password => 'ipassword', :password_confirmation => 'ipassword', :user_id => '10000008'
@j = User.create! :first_name => 'Harrison', :last_name => 'Barnes', :email => 'j@test.com', :password => 'jpassword', :password_confirmation => 'jpassword', :user_id => '10000009'
@k = User.create! :first_name => 'Andrew', :last_name => 'Bogut', :email => 'k@test.com', :password => 'kpassword', :password_confirmation => 'kpassword', :user_id => '10000010'
@a.add_role :student
@b.add_role :student
@c.add_role :student
@d.add_role :student
@e.add_role :student
@f.add_role :student
@g.add_role :student
@h.add_role :student
@i.add_role :student
@j.add_role :student
@k.add_role :student


#Creating Instructor Users
@mastakevin = User.create! :first_name => 'Kevin', :last_name => 'Casey', :email => 'kevin@test.com', :password => 'kevinpassword', :password_confirmation => 'kevinpassword', :user_id => '77777777'
@mastakevin.add_role :instructor
@phyllis = User.create! :first_name => 'Phil', :last_name => 'Kwon', :email => 'littleboy@test.com', :password => 'iamsmall', :password_confirmation => 'iamsmall', :user_id => '22222222'
@phyllis.add_role :instructor
@mastaricky = User.create! :first_name => 'William', :last_name => 'Li', :email => 'bigboy@test.com', :password => 'iamswole', :password_confirmation => 'iamswole', :user_id => '88888888'
@mastaricky.add_role :professor

#User Courses Relations
@carry = @mastaricky.courses.create! :course_name => 'CS 169', :user_id => '88888888'
@carry.users << @a
@carry.users << @b 
@carry.users << @c
@carry.users << @d
@carry.users << @e
@carry.users << @k
@pls = @mastaricky.courses.create! :course_name => 'CS 162', :user_id => '88888888'
@pls.users << @f
@pls.users << @g
@pls.users << @h
@pls.users << @i
@pls.users << @j
@pls.users << @k

#Adding Instructors to Courses
@carry.users << @mastakevin
@pls.users << @phyllis

#Creating Teams
@team1 = Team.create! :name => 'Team1', :course_id => @carry.id
@team2 = Team.create! :name => 'Team2', :course_id => @carry.id
@team3 = Team.create! :name => 'Team3', :course_id => @pls.id
@team4 = Team.create! :name => 'Team4', :course_id => @pls.id

#Adding Student Users to Teams
@team1.users << @a
@team1.users << @b
@team1.users << @c
@team2.users << @d
@team2.users << @e
@team2.users << @k

@team3.users << @f
@team3.users << @g
@team3.users << @h
@team4.users << @i
@team4.users << @j
@team4.users << @k

#Adding Instructor Users to Teams
@team1.users << @mastakevin
@team2.users << @mastakevin
@team3.users << @phyllis
@team4.users << @phyllis

#Adding teams to courses
@carry.teams << @team1
@carry.teams << @team2
@pls.teams << @team3
@pls.teams << @team4

#Creating Assignments for course
@proj1 = @carry.assignments.create! :assignment_name => 'proj1', :course_id => @carry.id, :deadline => DateTime.new(2015, 4, 30)
@carry.assignments.create! :assignment_name => 'proj2', :course_id => @carry.id, :deadline => DateTime.new(2015, 4, 29)

#Creating Feedbacks

@feed1 = Feedback.create! :comments => 'Nice job on the project! You have a good grasp of the concepts we learned in class and are a great partner as well!', :rating => '95', :giver_id => @k.user_id, :receiver_id => @e.user_id, :team_id => @team2.id
@feed2 = Feedback.create! :comments => 'Great job! You finished your portion of the project and also helped the rest of the team with theirs. Thanks for your help!', :rating => '100', :giver_id => @k.user_id, :receiver_id => @d.user_id, :team_id => @team2.id
@feed3 = Feedback.create! :comments => 'Try to particpate more next time. You seem to be lost in some concepts that we have learned during lectures. Although you gave your best effort, your lack of understanding in certain areas slowed down the team as a whole', :rating => '50', :giver_id => @e.user_id, :receiver_id => @k.user_id, :team_id => @team2.id
@feed4 = Feedback.create! :comments => 'It seems that you did not know what was going on. I understand that you are taking many classes this semester, but I do not think that is an excuse for slacking off on this project', :rating => '40', :giver_id => @d.user_id, :receiver_id => @k.user_id, :team_id => @team2.id

@proj1.feedbacks << @feed1
@proj1.feedbacks << @feed2
@proj1.feedbacks << @feed3
@proj1.feedbacks << @feed4




