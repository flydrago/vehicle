class Role
  include Mongoid::Document
  include Mongoid::Timestamps

  has_and_belongs_to_many :users
  belongs_to :resource, :polymorphic => true


  field :name, :type => String
  field :name_title, :type => String #中文名
  field :role_mark, :type => String ,default: 'business' #角色标识 business:运营商角色（对运营商），platform：平台角色（对平台）
  field :sequence, :type => Integer ,default: 0 #排序
  index({
            :name => 1,
            :resource_type => 1,
            :resource_id => 1
        },
        { :unique => true})

  validates :resource_type,
            :inclusion => { :in => Rolify.resource_types },
            :allow_nil => true

  validates :name, presence: true, uniqueness: true

  scopify

  def role_mark_str
    if self.role_mark=='business'
      p '单位'
    elsif self.role_mark=='platform'
      p '平台'
    elsif self.role_mark=='jxc'
      p '进销存'
    end

  end
end