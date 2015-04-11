require 'rails_helper'

RSpec.describe "instructors/new", type: :view do
  before(:each) do
    assign(:instructor, Instructor.new(
      :name => "MyText",
      :sid => "MyText",
      :email => "MyText",
      :teams => "MyText"
    ))
  end

  it "renders new instructor form" do
    render

    assert_select "form[action=?][method=?]", instructors_path, "post" do

      assert_select "textarea#instructor_name[name=?]", "instructor[name]"

      assert_select "textarea#instructor_sid[name=?]", "instructor[sid]"

      assert_select "textarea#instructor_email[name=?]", "instructor[email]"

      assert_select "textarea#instructorr_teams[name=?]", "instructor[teams]"
    end
  end
end
