require 'rails_helper'

RSpec.describe "instructors/show", type: :view do
  before(:each) do
    @instructor = assign(:instructor, Instructor.create!(
      :name => "MyText",
      :sid => "MyText",
      :email => "MyText",
      :teams => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
  end
end
