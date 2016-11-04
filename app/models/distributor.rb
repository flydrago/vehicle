class Distributor
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip
  include Mongoid::Attributes::Dynamic

  field :distributor_name, type: String #分销商单位名称
  field :contact_name, type: String #分销商联系人姓名
  field :phone_number, type: String #分销商联系电话号
  field :distributor_address, type: String #地址

  has_many :distri_product_infos #一对多关联分销商品信息

end
