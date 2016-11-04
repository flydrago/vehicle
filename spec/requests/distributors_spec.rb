require 'rails_helper'

RSpec.describe "Distributors", type: :request do
  describe "GET /distributors" do
    it "works! (now write some real specs)" do
      get distributors_path
      expect(response).to have_http_status(200)
    end
  end
end
