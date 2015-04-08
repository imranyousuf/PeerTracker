require 'rails_helper'

RSpec.describe "teachers/edit", type: :view do
  before(:each) do
    @teacher = assign(:teacher, Teacher.create!(
      :name => "MyText",
      :email => "MyText",
      :score => "MyText"
    ))
  end

  it "renders the edit teacher form" do
    render

    assert_select "form[action=?][method=?]", teacher_path(@teacher), "post" do

      assert_select "textarea#teacher_name[name=?]", "teacher[name]"

      assert_select "textarea#teacher_email[name=?]", "teacher[email]"

      assert_select "textarea#teacher_score[name=?]", "teacher[score]"
    end
  end
end
