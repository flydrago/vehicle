namespace :role do
  ##给所有的单位添加某一个指定的角色,按照角色英文名
  task :add_role_to_all_userinfos,[:role_name] => :environment do |t,args|
    role = Role.where({:name=>args[:role_name]}).first ##根据角色名字查找角色对象
    Userinfo.where({:role_marks => "business"}).each do |user_info|
      init_user = user_info.users.where(:user_flag => 1).first ##查询小B的一个初始化用户 user_flag = 1 表示初始化用户
      if init_user.present?
        init_user.add_to_set('role_ids' => BSON::ObjectId(role.id)) ##更新小B的初始化用户角色信息
      end
      user_info.add_to_set('role_ids' => BSON::ObjectId(role.id)) ##更新小B的角色信息
    end
    p "所用单位以及初始化用户添加角色完毕!"
  end


  ##给所有的单位删除指定角色,按照角色英文名
  task :remove_role_to_all_userinfos,[:role_name] => :environment do |t,args|
    role = Role.where({:name=>args[:role_name]}).first ##根据角色名字查找角色对象
    Userinfo.where({:role_marks => "business"}).each do |user_info|
      init_user = user_info.users.where(:user_flag => 1).first ##查询小B的一个初始化用户 user_flag = 1 表示初始化用户
      if init_user.present?
        init_user.pull('role_ids' => BSON::ObjectId(role.id)) ##更新小B的初始化用户角色信息
      end
      user_info.pull('role_ids' => BSON::ObjectId(role.id)) ##更新小B的角色信息
    end
    p "所用单位以及初始化用户删除角色完毕!"
  end

  ##给指定的单位添加角色,按照角色英文名
  task :add_role_to_specify_userinfo,[:userinfo_id,:role_name] => :environment do |t,args|
    role = Role.where({:name=>args[:role_name]}).first ##根据角色名字查找角色对象
    begin
      user_info = Userinfo.find(args[:userinfo_id])
      init_user = user_info.users.where(:user_flag => 1).first ##查询小B的一个初始化用户 user_flag = 1 表示初始化用户
      if init_user.present?
        init_user.add_to_set('role_ids' => BSON::ObjectId(role.id)) ##更新小B的初始化用户角色信息
      end
      user_info.add_to_set('role_ids' => BSON::ObjectId(role.id)) ##更新小B的角色信息
      p "特定单位添加角色完毕!"
    rescue => e
      p "#{e.message}"
    end

  end


  ##把所有的单位角色分配给所有的单位以及初始化的用户
  task :add_all_roles_to_all_userinfo => :environment do
    Userinfo.where({:role_marks => "business"}).each do |user_info|  ##遍历所有的单位
      init_user = user_info.users.where(:user_flag => 1).first ##查询小B的一个初始化用户 user_flag = 1 表示初始化用户
      Role.where({:role_mark => "business"}).each do |role| ##遍历所有是单位的角色
        if init_user.present?
          init_user.add_to_set('role_ids' => BSON::ObjectId(role.id)) ##更新小B的初始化用户角色信息
        end
        user_info.add_to_set('role_ids' => BSON::ObjectId(role.id)) ##更新小B的角色信息
      end
    end
    p "所有单位角色(所有属于单位的角色)分配完毕!"
  end


  #########################################################################################
  ##### 针对平台账户分配角色
  #########################################################################################
  ##给平台用户添加某一个指定的角色,按照角色英文名
  task :add_role_to_all_platform,[:role_name] => :environment do |t,args|
    role = Role.where({:name=>args[:role_name]}).first ##根据角色名字查找角色对象
    Userinfo.where({:role_marks => "platform"}).each do |user_info|
      init_user = user_info.users.where(:user_flag => 1).first ##查询小B的一个初始化用户 user_flag = 1 表示初始化用户
      if init_user.present?
        init_user.add_to_set('role_ids' => BSON::ObjectId(role.id)) ##更新小B的初始化用户角色信息
      end
      user_info.add_to_set('role_ids' => BSON::ObjectId(role.id)) ##更新小B的角色信息
    end
    p "所有平台账户以及初始化用户添加角色完毕!"
  end

  ##给平台账户删除指定角色,按照角色英文名
  task :remove_role_to_all_platform,[:role_name] => :environment do |t,args|
    role = Role.where({:name=>args[:role_name]}).first ##根据角色名字查找角色对象
    Userinfo.where({:role_marks => "platform"}).each do |user_info|
      init_user = user_info.users.where(:user_flag => 1).first ##查询小B的一个初始化用户 user_flag = 1 表示初始化用户
      if init_user.present?
        init_user.pull('role_ids' => BSON::ObjectId(role.id)) ##更新小B的初始化用户角色信息
      end
      user_info.pull('role_ids' => BSON::ObjectId(role.id)) ##更新小B的角色信息
    end
    p "所有平台账户以及初始化用户删除角色完毕!"
  end

  ##给指定的平台账户添加角色,按照角色英文名
  task :add_role_to_specify_platform,[:userinfo_id,:role_name] => :environment do |t,args|
    role = Role.where({:name=>args[:role_name]}).first ##根据角色名字查找角色对象
    begin
      user_info = Userinfo.find(args[:userinfo_id])
      init_user = user_info.users.where(:user_flag => 1).first ##查询小B的一个初始化用户 user_flag = 1 表示初始化用户
      if init_user.present?
        init_user.add_to_set('role_ids' => BSON::ObjectId(role.id)) ##更新小B的初始化用户角色信息
      end
      user_info.add_to_set('role_ids' => BSON::ObjectId(role.id)) ##更新小B的角色信息
      p "特定平台账户添加角色完毕!"
    rescue => e
      p "#{e.message}"
    end
  end

  ##把所有的平台角色分配给所有的平台账户以及初始化的用户
  task :add_all_roles_to_all_platform => :environment do
    Userinfo.where({:role_marks => "platform"}).each do |user_info|  ##遍历所有的平台账户小B
      init_user = user_info.users.where(:user_flag => 1).first ##查询小B的一个初始化用户 user_flag = 1 表示初始化用户
      Role.where({:role_mark => "platform"}).each do |role| ##遍历所有是平台的角色
        if init_user.present?
          init_user.add_to_set('role_ids' => BSON::ObjectId(role.id)) ##更新小B的初始化用户角色信息
        end
        user_info.add_to_set('role_ids' => BSON::ObjectId(role.id)) ##更新小B的角色信息
      end
    end
    p "所有平台角色(所有属于平台的角色)分配完毕!"
  end


end
