require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "selectors"))

Given /^the course is set up:$/ do
	Course.create() 
end

Given /^I visit this specific page$/ do
  visit "/courses/1"
end

Given(/^the following users exist:$/) do |users_table|
  users_table.hashes.each do |user|
  	User.create!(user)
  end
end

Given /the following roles exist:/ do |roles_table|
  roles_table.hashes.each do |role|
  	Role.create!(role)
  end
end

Given /the following users_roles exist:/ do |users_roles_table|
  users_roles_table.hashes.each do |user_role|
    @user = User.where(:user_id => user_role[:user_id]).first
    @role = Role.find(user_role[:role_id])
    @user.add_role @role.name
  end
end

Given /the following courses exist:/ do |courses_table|
  courses_table.hashes.each do |course|
  	user = User.where(:user_id => course[:user_id]).first
    course = Course.create!(course)
    user.courses << course
  end
end

Given /the following courses_users exist:/ do |courses_users_table|
  courses_users_table.hashes.each do |course_user|
    @course = Course.find(course_user[:course_id])
    @user = User.where(:user_id => course_user[:user_id]).first
    @course.users << @user
    puts @user.courses.inspect
  end
end

Given /the following teams exist:/ do |teams_table|
  teams_table.hashes.each do |team|
  	Team.create!(team)
  end
end

Given /the following users_teams exist:/ do |users_teams_table|
  users_teams_table.hashes.each do |user_team|
    @user = User.where(:user_id => user_team[:user_id]).first
    @team = Team.where(:id => user_team[:team_id]).first
    @team.users << @user
  end
end

Given /the following assignments exist:/ do |assignments_table|
  assignments_table.hashes.each do |assignment|
  	Assignment.create!(assignment)
  end
end

Given /the following feedbacks exist:/ do |feedbacks_table|
  feedbacks_table.hashes.each do |feedback|
    Feedback.create!(feedback)
  end
end

Given /^I am signed on with uid: (.+)$/ do |uid|
  include Devise::TestHelpers
  visit path_to('the sign in page')
  @user = User.where(:user_id => uid.to_i).first
  fill_in("Email", :with=>@user.email)
  puts @user.email
  puts @user.password
  puts @user.created_at
  fill_in("Password", :with=>"password")
  click_button("Log in")
end
