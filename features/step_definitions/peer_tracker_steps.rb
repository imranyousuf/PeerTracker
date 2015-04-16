require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "selectors"))

Given /^the course is set up:$/ do
	Course.create() 
end

Given /the following users exist/ do |users_table|
  users_table.hashes.each do |user|
  	User.create!(user)
  end
end

Given /the following users_roles exist/ do |users_roles_table|
  users_roles_table.hashes.each do |user_role|
    #@user = User.find(user_role[:user_id])
    #oles.create!(user_role)
  end
end

Given /the following courses exist/ do |courses_table|
  courses_table.hashes.each do |course|
  	Course.create!(user)
  end
end

Given /the following courses_users exist/ do |courses_users_table|
  courses_users_table.hashes.each do |course_user|
  	CourseUser.create!(course_user)
  end
end

Given /the following teams exist/ do |teams_table|
  teams_table.hashes.each do |team|
  	Team.create!(team)
  end
end

Given /the following users_teams exist/ do |users_teams_table|
  users_teams_table.hashes.each do |user_team|
  	UserTeam.create!(user_team)
  end
end

Given /the following assignments exist/ do |assignments_table|
  assignments_table.hashes.each do |assignment|
  	Assignment.create!(assignment)
  end
end
