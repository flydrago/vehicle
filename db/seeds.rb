# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


#基础字典数据初始化（公用数据）
def base_data_init


  ##单位角色(一级菜单功能角色)
  Role.create(:name => "system_management", :role_mark => "business",:name_title => "系统管理")

  #平台角色
  Role.create(:name => "SuperAdmin", :role_mark => "platform",:name_title => "超级管理员") #超级管理员
  Role.create(:name => "userinfo_admin", :role_mark => "platform",:name_title => "单位管理员") #单位管理员
end


#初始化平台运营商信息
def init_userinfo

  #初始化平台账号
  platform_userinfo = Userinfo.create(:id => BSON::ObjectId("56c45924c2fb4e205000000d"),
                                      :shopname => "车辆管理系统平台",
                                      :mobile =>  "12345678900",
                                      :name =>  "平台",
                                      :email =>  "12345678900@163.com",
                                      :idnumber => "41111111111111111111111",
                                      :remark => "车辆管理",
                                      :role_marks => ["platform"],
                                      :role_ids => Role.where({:role_mark => "platform"}).collect{|r| r.id},
                                      :status => 1)

  User.create( :name => "管理员",
               :mobile => "12345678900",
               :email => "12345678900@163.com",
               :password => "123456",
               :password_confirmation => "123456",
               :userinfo => platform_userinfo,
               :roles => Role.where({:role_mark => "platform"}))
end

#基础数据初始化
base_data_init()
#初始化运营商信息
init_userinfo()