class Vehicleinfo
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip
  include Mongoid::Attributes::Dynamic

  field :vehicle_brand, type: String  ##车辆品牌
  field :vehicle_name, type: String   ##车辆名称
  field :vehicle_model, type: String  ##车辆型号
  field :vehicle_style, type: String  ##车辆款式(舒适性,豪华型等)
  field :vehicle_color, type: String  ##车辆颜色
  field :vehicle_engine_number, type: String  ##车辆发动机号
end
