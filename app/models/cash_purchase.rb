class CashPurchase
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Attributes::Dynamic
  belongs_to :userinfo #存放运营商id
  belongs_to :consumer_info #关联用户信息
  belongs_to :vehicleinfo #关联车辆信息
  field :licenseplatenumber, :type => String #车牌号
  field :buyingtime, :type => DateTime #购买日起
  field :carprice, :type => Float #车价钱
  field :scheduledmaintenance, :type => DateTime #预定保养时间
  ####用户信息
  field :name, type: String #姓名
  field :identity_card, type: String #身份证号
  field :mobile, type: String # 手机号
  ####车辆信息
  field :vehicle_brand, type: String ##车辆品牌
  field :vehicle_name, type: String ##车辆名称
  field :vehicle_model, type: String ##车辆型号
  field :vehicle_style, type: String ##车辆款式(舒适性,豪华型等)
  field :vehicle_color, type: String ##车辆颜色
  field :vehicle_engine_number, type: String ##车辆发动机号
  validates :licenseplatenumber,presence: true, length: {maximum: 20, too_long: "最大长度为%{count}个字符"}
  validates :buyingtime, presence: true
  validates :carprice, presence: true
  validates :scheduledmaintenance, presence: true

  ####判断关联的数据不能为空
  validates :name, presence: true
  validates :identity_card, presence: true
  validates :mobile, presence: true
  validates :vehicle_brand, presence: true
  validates :vehicle_name, presence: true
  validates :vehicle_model, presence: true
  validates :vehicle_style, presence: true
  validates :vehicle_color, presence: true
  validates :vehicle_engine_number, presence: true
end
