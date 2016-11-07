class Userinfo
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip
  include Mongoid::Geospatial

  field :role_ids, type: Array,default: [] #角色[]
  field :idnumber, type: String #身份证号码1
  field :shopname, type: String # 经营者商店名称1
  field :mobile, type: String # 经营者商店名称1
  field :name, type: String # 经营者姓名1
  field :email, type: String #邮箱 唯一
  field :remark, type: String, default: '' #描述
  field :role_marks, type: Array, default: [] #角色标识 business: 运营商角色（对运营商），platform：平台角色（对平台）
  field :status, type: Integer, default: 0 #启用状态，0初始化，1启用，-1禁用1
  validates :name, :email, :shopname, presence: true #名称，种类不能为空
  validates :mobile, presence: true, format: {with: /\A\d{11}\z/, message: "不合法!"}

  has_mongoid_attached_file :busp, :default_url => '/missing.png'
  validates_attachment_content_type :busp, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  has_mongoid_attached_file :footp, :default_url => '/missing.png'
  validates_attachment_content_type :footp, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  has_mongoid_attached_file :healthp, :default_url => '/missing.png'
  validates_attachment_content_type :healthp, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  has_mongoid_attached_file :taxp, :default_url => '/missing.png'
  validates_attachment_content_type :taxp, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  has_mongoid_attached_file :orgp, :default_url => '/missing.png'
  validates_attachment_content_type :orgp, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  has_mongoid_attached_file :idpf, :default_url => '/missing.png'
  validates_attachment_content_type :idpf, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  has_mongoid_attached_file :idpb, :default_url => '/missing.png'
# ,
#                           :path => "public/upload/image:class/:id/:filename",
#                           :url => "/upload/image/:class/:id/:basename.:extension"
  validates_attachment_content_type :idpb, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]


  #是否为运营商
  def is_business

    self.role_marks.present? && self.role_marks.include?('business')
  end

  #是否为平台
  def is_platform

    self.role_marks.present? && self.role_marks.include?('platform')
  end

  def status_str
    if self.status==0
      return '待审核'
    elsif self.status==1
      return '已启用'
    else
      return '已停用'
    end
  end

end

