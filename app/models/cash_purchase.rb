class CashPurchase
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Attributes::Dynamic

  belongs_to :Userinfo #存放运营商id
  field :licenseplatenumber, :type => String #车牌号
  field :colour, :type => String #颜色
  field :motornumber, :type => String #电动机号码
  field :enginenumber, :type => String  #发动机号码
  field :buyingtime, :type => DateTime  #购买日起
  field :carprice, :type => Float  #车价钱
  field :scheduledmaintenance , :type => DateTime  #预定保养时间

  validates :licenseplatenumber, uniqueness: {message: "已存在" },presence: true, length: {maximum: 20, too_long: "最大长度为%{count}个字符"}
  validates :colour, presence: true,  length: {maximum: 5, too_long: "最大长度为%{count}个字符"}
  validates :motornumber, uniqueness: {message: "已存在" },presence: true, length: {maximum: 20, too_long: "最大长度为%{count}个字符"}
  validates :enginenumber, uniqueness: {message: "已存在" },presence: true, length: {maximum: 20, too_long: "最大长度为%{count}个字符"}
  validates :buyingtime, presence: true
  validates :carprice, presence: true
  validates :scheduledmaintenance, presence: true
end
