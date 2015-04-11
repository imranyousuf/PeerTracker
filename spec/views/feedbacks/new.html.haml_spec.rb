require 'rails_helper'

RSpec.describe "feedbacks/new", type: :view do
  before(:each) do
    assign(:feedback, Feedback.new(
      :comments => "MyText",
      :ratings => 1.5
    ))
  end

  it "renders new feedback form" do
    render

    assert_select "form[action=?][method=?]", feedbacks_path, "post" do

      assert_select "textarea#feedback_comments[name=?]", "feedback[comments]"

      assert_select "input#feedback_ratings[name=?]", "feedback[ratings]"
    end
  end
end
