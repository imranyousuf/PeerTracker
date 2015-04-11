require 'rails_helper'

RSpec.describe "Instructors", type: :request do
  describe "GET /instructors" do
    it "works! (now write some real specs)" do
      get instructors_path
      expect(response).to have_http_status(200)
    end
  end
end
