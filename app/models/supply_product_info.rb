class SupplyProductInfo
  include Mongoid::Document
  include Mongoid::Timestamps
  field :purchasePrice, type: Float
  field :count, type: Integer
  field :payable_money, type: Float #应付金额
  field :payreal_money, type: Float #是否金额
end
