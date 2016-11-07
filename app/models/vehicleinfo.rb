class Vehicleinfo
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip
  include Mongoid::Attributes::Dynamic
  has_many :cash_purchases
  field :vehicle_brand, type: String  ##车辆品牌
  field :vehicle_name, type: String   ##车辆名称
  field :vehicle_model, type: String  ##车辆型号
  field :vehicle_style, type: String  ##车辆款式(舒适性,豪华型等)
  field :vehicle_color, type: String  ##车辆颜色
  field :vehicle_engine_number, type: String  ##车辆发动机号
  field :is_sold, type: Boolean ,default: false ##是否已经销售

  validates :vehicle_brand, presence: true
  validates :vehicle_name, presence: true
  validates :vehicle_model, presence: true
  validates :vehicle_style, presence: true
  validates :vehicle_color, presence: true
  validates :vehicle_engine_number, uniqueness: {message: "已存在" }, presence: true, length: {maximum: 20, too_long: "最大长度为%{count}个字符"}
end
