require 'rails_helper'

RSpec.describe "students/new", type: :view do
  before(:each) do
    assign(:student, Student.new(
      :name => "MyText",
      :sid => "MyText",
      :email => "MyText",
      :instructor => "MyText",
      :team => "MyText"
    ))
  end

  it "renders new student form" do
    render

    assert_select "form[action=?][method=?]", students_path, "post" do

      assert_select "textarea#student_name[name=?]", "student[name]"

      assert_select "textarea#student_sid[name=?]", "student[sid]"

      assert_select "textarea#student_email[name=?]", "student[email]"

      assert_select "textarea#student_instructor[name=?]", "student[instructor]"

      assert_select "textarea#student_team[name=?]", "student[team]"
    end
  end
end
