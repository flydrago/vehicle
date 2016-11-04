class Supplier
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :mobile, type: String
  field :address, type: String
  field :contact_name, type:String  #联系人姓名
end
