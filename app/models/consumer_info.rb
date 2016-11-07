class ConsumerInfo
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip
  include Mongoid::Geospatial


  field :name, type: String #姓名
  field :birthday, type: DateTime #生日
  field :identity_card, type: String #身份证号
  field :address, type: String, default: "" #地址
  field :mobile, type: String # 手机号

  belongs_to :userinfo

  has_mongoid_attached_file :picture, :default_url => '/customer_missing.png'
  validates_attachment_content_type :picture, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  validates :identity_card, uniqueness: {scope: :userinfo, message: "已存在"}, presence: true, length: {maximum: 18, too_long: "最大长度为%{count}个字符"}
  validates :mobile, uniqueness: {scope: :userinfo, message: "已存在"}, presence: true, format: {with: /1[3|4|5|7|8]\d{9}\z/, message: "不合法!"}

end
