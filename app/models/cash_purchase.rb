class CashPurchase
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Attributes::Dynamic

  field :licenseplatenumber, :type => String #车牌号
  field :colour, :type => String #颜色
  field :motornumber, :type => String #电动机号码
  field :enginenumber, :type => String  #发动机号码
  field :buyingtime, :type => DateTime  #购买日起
  field :carprice, :type => Float  #车价钱
  field :scheduledmaintenance , :type => DateTime  #预定保养时间
end
