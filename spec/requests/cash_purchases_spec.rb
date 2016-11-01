require 'rails_helper'

RSpec.describe "CashPurchases", type: :request do
  describe "GET /cash_purchases" do
    it "works! (now write some real specs)" do
      get cash_purchases_path
      expect(response).to have_http_status(200)
    end
  end
end
