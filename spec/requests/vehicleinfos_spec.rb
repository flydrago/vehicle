require 'rails_helper'

RSpec.describe "Vehicleinfos", type: :request do
  describe "GET /vehicleinfos" do
    it "works! (now write some real specs)" do
      get vehicleinfos_path
      expect(response).to have_http_status(200)
    end
  end
end
