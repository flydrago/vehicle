require 'rails_helper'

RSpec.describe "DistriProductInfos", type: :request do
  describe "GET /distri_product_infos" do
    it "works! (now write some real specs)" do
      get distri_product_infos_path
      expect(response).to have_http_status(200)
    end
  end
end
