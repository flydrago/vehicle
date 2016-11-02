class ConsumerInfo
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip
  include Mongoid::Geospatial


  field :name, type: String #姓名
  field :birthday, type: DateTime #生日
  field :identity_card,type: String #身份证号
  field :address,type: String,default: "" #地址
  field :mobile, type: String # 手机号
  has_mongoid_attached_file :picture, :default_url => '/customer_missing.png'
  validates_attachment_content_type :picture, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]




end
