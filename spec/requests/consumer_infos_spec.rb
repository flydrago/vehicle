require 'rails_helper'

RSpec.describe "ConsumerInfos", type: :request do
  describe "GET /consumer_infos" do
    it "works! (now write some real specs)" do
      get consumer_infos_path
      expect(response).to have_http_status(200)
    end
  end
end
