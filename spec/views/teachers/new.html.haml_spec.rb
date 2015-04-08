require 'rails_helper'

RSpec.describe "teachers/new", type: :view do
  before(:each) do
    assign(:teacher, Teacher.new(
      :name => "MyText",
      :email => "MyText",
      :score => "MyText"
    ))
  end

  it "renders new teacher form" do
    render

    assert_select "form[action=?][method=?]", teachers_path, "post" do

      assert_select "textarea#teacher_name[name=?]", "teacher[name]"

      assert_select "textarea#teacher_email[name=?]", "teacher[email]"

      assert_select "textarea#teacher_score[name=?]", "teacher[score]"
    end
  end
end
