# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#


#Creating Student Users
@a = User.create! :name => 'A', :email => 'a@test.com', :password => 'apassword', :password_confirmation => 'apassword', :user_id => '10000000'
@b = User.create! :name => 'B', :email => 'b@test.com', :password => 'bpassword', :password_confirmation => 'bpassword', :user_id => '10000001'
@c = User.create! :name => 'C', :email => 'c@test.com', :password => 'cpassword', :password_confirmation => 'cpassword', :user_id => '10000002'
@d = User.create! :name => 'D', :email => 'd@test.com', :password => 'dpassword', :password_confirmation => 'dpassword', :user_id => '10000003'
@e = User.create! :name => 'E', :email => 'e@test.com', :password => 'epassword', :password_confirmation => 'epassword', :user_id => '10000004'
@f = User.create! :name => 'F', :email => 'f@test.com', :password => 'fpassword', :password_confirmation => 'fpassword', :user_id => '10000005'
@g = User.create! :name => 'G', :email => 'g@test.com', :password => 'gpassword', :password_confirmation => 'gpassword', :user_id => '10000006'
@h = User.create! :name => 'H', :email => 'h@test.com', :password => 'hpassword', :password_confirmation => 'hpassword', :user_id => '10000007'
@i = User.create! :name => 'I', :email => 'i@test.com', :password => 'ipassword', :password_confirmation => 'ipassword', :user_id => '10000008'
@j = User.create! :name => 'J', :email => 'j@test.com', :password => 'jpassword', :password_confirmation => 'jpassword', :user_id => '10000009'
@k = User.create! :name => 'K', :email => 'k@test.com', :password => 'kpassword', :password_confirmation => 'kpassword', :user_id => '10000010'

#Creating Instructor Users
@mastakevin = User.create! :name => 'MUDDAFUDGING KEVIN', :email => 'kevin@test.com', :password => 'kevinpassword', :password_confirmation => 'kevinpassword', :user_id => '77777777'
@phyllis = User.create! :name => 'SERVANT PHIL', :email => 'littleboy@test.com', :password => 'iamsmall', :password_confirmation => 'iamsmall', :user_id => '22222222'
@mastaricky = User.create! :name => 'MASTA RICKY', :email => 'bigboy@test.com', :password => 'iamswole', :password_confirmation => 'iamswole', :user_id => '88888888'

#User Courses Relations
@carry = @mastaricky.courses.create! :course_name => 'CARRY101', :user_id => '88888888'
@carry.users << @a
@carry.users << @b 
@carry.users << @c
@carry.users << @d
@carry.users << @e
@carry.users << @k
@pls = @mastakevin.courses.create! :course_name => 'PLSDOWORK', :user_id => '77777777'
@pls.users << @f
@pls.users << @g
@pls.users << @h
@pls.users << @i
@pls.users << @j
@pls.users << @k

@a.courses << @carry
@b.courses << @carry
@c.courses << @carry
@d.courses << @carry
@e.courses << @carry
@k.courses << @carry

@f.courses << @pls
@g.courses << @pls
@h.courses << @pls
@i.courses << @pls
@j.courses << @pls
@k.courses << @pls

#Creating Teams
@team1 = Team.create! :name => 'Team1', :course_id => @carry.id
@team2 = Team.create! :name => 'Team2', :course_id => @carry.id
@team3 = Team.create! :name => 'Team3', :course_id => @pls.id
@team4 = Team.create! :name => 'Team4', :course_id => @pls.id

#Adding Users to Teams
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

@a.teams << @team1
@b.teams << @team1
@c.teams << @team1
@d.teams << @team2
@e.teams << @team2
@k.teams << @team2

@f.teams << @team3
@g.teams << @team3
@h.teams << @team3
@i.teams << @team4
@j.teams << @team4
@k.teams << @team4

#Adding teams to courses
@carry.teams << @team1
@carry.teams << @team2
@pls.teams << @team3
@pls.teams << @team4






