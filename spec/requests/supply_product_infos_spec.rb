require 'rails_helper'

RSpec.describe "SupplyProductInfos", type: :request do
  describe "GET /supply_product_infos" do
    it "works! (now write some real specs)" do
      get supply_product_infos_path
      expect(response).to have_http_status(200)
    end
  end
end
