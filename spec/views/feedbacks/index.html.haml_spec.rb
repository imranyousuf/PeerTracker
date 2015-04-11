require 'rails_helper'

RSpec.describe "feedbacks/index", type: :view do
  before(:each) do
    assign(:feedbacks, [
      Feedback.create!(
        :comments => "MyText",
        :ratings => 1.5
      ),
      Feedback.create!(
        :comments => "MyText",
        :ratings => 1.5
      )
    ])
  end

  it "renders a list of feedbacks" do
    render
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
  end
end
