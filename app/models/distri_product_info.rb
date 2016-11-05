class DistriProductInfo
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip
  include Mongoid::Attributes::Dynamic

  field :product_name, type: String #产品名称
  field :product_model, type: String #产品型号
  field :product_price, type: Float ,default:0 #产品单价
  field :product_count, type: Integer #产品数量
  field :should_get_money, type: Float ,default:0 #应收款
  field :real_get_money, type: Float ,default:0 #实收款

  belongs_to :distributor
  has_many :vehicleinfos
end
