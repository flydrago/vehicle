class Vehicleinfo
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip
  include Mongoid::Attributes::Dynamic

  field :vehicle_brand, type: String  ##车辆品牌
  field :vehicle_name, type: String   ##车辆名称
  field :vehicle_model, type: String  ##车辆类型 (机动车或非机动车)
  field :vehicle_style, type: String  ##车辆款式(舒适性,豪华型等)
end
