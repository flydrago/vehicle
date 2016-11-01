class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip
  include Mongoid::Attributes::Dynamic

  rolify
  attr_accessor :shop_name
  belongs_to :userinfo, :foreign_key => :userinfo_id
  before_save :ensure_authentication_token
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :token_authenticatable,
         :rememberable, :trackable, :validatable, :registerable

  ## Database authenticatable
  field :email, type: String, default: ""
  field :encrypted_password, type: String, default: ""
  field :name, type: String, default: ""
  field :mobile, type: String
  field :authentication_token
  field :tmpcode, type: String, default: "" #临时验证吗
  field :step, type: Integer #状态  #创建状态1 只能验证邮箱  #创建状态3 只能选择用户角色，上传信息#创建状态9  审核成功
  field :activation_token, type: String #邮箱验证码

  field :audit_desc, type: String #审批备注信息
  field :user_flag, type: Integer, default: 0 #用户标识  0为普通用户，1：初始化用户（不可修改和删除）

  #field :admin

  has_mongoid_attached_file :avatar, :default_url => '/images/avatar.png'

  validates_attachment_content_type :avatar, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  validates :name, presence: true, length: {maximum: 20, too_long: "最大长度为%{count}个字符"}
  validates :mobile, presence: true, uniqueness: true, format: {with: /\A\d{11}\z/, message: "不合法!"}
  validates :email, presence: true

  ## Recoverable
  field :reset_password_token, type: String
  field :reset_password_sent_at, type: Time


  ## Rememberable
  field :remember_created_at, type: Time

  ## Trackable
  field :sign_in_count, type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at, type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip, type: String

  ## Confirmable
  field :confirmation_token, type: String
  field :confirmation_token_at, type: Time
  # field :confirmed_at,         type: Time
  # field :confirmation_sent_at, type: Time
  # field :unconfirmed_email,    type: String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, type: Integer, default: 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    type: String # Only if unlock strategy is :email or :both
  # field :locked_at,       type: Time
  has_and_belongs_to_many :roles #角色

  #addby dfj
  # def send_password_reset
  #   generate_token(:reset_password_token)
  #   self.reset_p#assword_sent_at = Time.zone.now
  #   save!
  #
  # end
  #
  # def generate_token(column)
  #   begin
  #     self[column] = SecureRandom.urlsafe_base64
  #   end
  # end

  def email_required?
    false
  end

  def as_json(options=nil)
    super(:methods => [:avatar_url, :shop_name])
  end

  def avatar_url
    self.avatar.url
  end

  def set_confirmation_token
    self.confirmation_token = generate_authentication_token
    self.confirmation_token_at = Time.now.zone
  end

  # private
  # def generate_authentication_token
  #   loop do
  #     token = Devise.friendly_token
  #     break token unless User.where(authentication_token: token).first
  #   end
  # end#

  #重写角色方法
  def roles

    if !self.userinfo.present? || self.userinfo.is_platform
      current_role_ids = self['role_ids'].present? ? self['role_ids'] : []
    else
      userinfo_role_ids = self.userinfo['role_ids'].present? ? self.userinfo['role_ids'] : []
      user_role_ids = self['role_ids'].present? ? self['role_ids'] : []
      current_role_ids = user_role_ids&userinfo_role_ids
    end
    @roles ||= Role.where(:_id => {'$in' => current_role_ids})
  end

end
