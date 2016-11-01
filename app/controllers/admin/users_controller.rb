class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  before_action :auth?

  def index
    @current_user = current_user
    # name = params[:user_name]
    # mobile = params[:user_mobile]
    # whereParams = {} #查询条件
    # whereParams['name'] = /#{name}/ if name.present?
    # whereParams['mobile'] = /#{mobile}/ if mobile.present?
    # whereParams['userinfo_id'] = @current_user['userinfo_id']
    # @users = User.where(whereParams).page(params[:page])

    respond_to do |format|
      format.html
      format.json { render json: UsersDatatable.new(view_context, current_user) }
    end
  end

  #添加新用户,并对角色进行过滤
  def new
    @user = User.new
    @current_user = current_user
    userinfo = Userinfo.find(@current_user.userinfo_id)
    @roles = []
    if userinfo.role_ids.size() > 0  ##小B所拥有的权限
      userinfo.role_ids.each do |role_id|
        @roles << Role.find(role_id)
      end
    else  ##小B初始化的用户的权限
      user = User.where({:mobile => userinfo.pusher_phone}).first() ##新建小B初始化的用户=>初始化用户有初始化的权限
      user.role_ids.each do |role_id|
        @roles << Role.find(role_id)
      end
    end

    #
    # role_mark = userinfo.role_marks
    # @roles = Role.where({'role_mark' => {'$in' => role_mark}})
  end

  def show
    if @app_key.present?
      @user=User.find(params[:id])
    else
      @user = User.find(params[:id])
    end
  end

  def edit
    # @roles = Role.all
    @current_user = current_user
    userinfo = Userinfo.find(@current_user.userinfo_id)
    # role_mark = userinfo.role_marks
    # @roles = Role.where({'role_mark' => {'$in' => role_mark}})
    @roles = []
    userinfo.role_ids.each do |role_id|
      @roles << Role.find(role_id)
    end
  end

  #创建用户
  def create
    @user = User.new(user_params)
    #初始化密码: 123456
    @user.password = "123456"
    @user['userinfo_id'] = current_user['userinfo_id']
    if @app_key.present?
      @user.userinfo=Userinfo.create(pdistance: 1)
    end
    respond_to do |format|
      @user['role_ids'] = []
      unless params[:user][:roles].blank?
        params[:user][:roles].each do |role|
          role_model = Role.where({:name => role}).first
          @user['role_ids'] << role_model.id if role_model.present?
        end
      end
      if @user.save
        format.js { render_js_for_form(@user,admin_users_path,'用户创建成功!') }
        format.js { render_js admin_users_path, '用户创建成功!' }
      else
        format.js { render_js_for_form(@user) }
      end
    end
  end


  def password
    p params
  end

  def upload
    @user=User.find(current_user.id)
    # @user.avatar.destroy
    @user.avatar= params[:user][:avatar]
    @user.save
    respond_to do |format|
      format.html { redirect_to "/#/userinfos/#{current_user.userinfo_id}" }
      format.js { render_js "/#/userinfos/#{current_user.userinfo_id}" }
    end
  end

  def update

    respond_to do |format|
      result = false
      if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
        result = @user.update_without_password(user_params)
      else
        result = @user.update(user_params)
      end
      if result
        @user['role_ids'] = []
        unless params[:user][:roles].blank?
          params[:user][:roles].each do |role|
            role_model = Role.where({:name => role}).first
            @user['role_ids'] << role_model.id if role_model.present?
            # @user.add_role role
          end
        end
        @user.save
        # format.html { redirect_to [:admin, @user], notice: 'User was successfully updated.' }
        # format.json { render :show, status: :ok }
        # format.js { render_js admin_users_path(@user) }
        format.js { render_js_for_form(@user,admin_users_path) }
        # format.json { render json: get_render_common_json(@user,admin_users_path(@user)) }
      else
        format.js { render_js_for_form(@user) }
        # format.html { render :edit }
        # format.json { render json: @user.errors, status: :unprocessable_entity }
        # format.js { render_js edit_admin_user_path(@user) }
        # format.json { render json: get_render_common_json(@user) }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      # format.html { redirect_to admin_users_path, notice: 'User was successfully destroyed.' }
      format.js { render_js admin_users_path, notice: '用户已成功删除!' }
      format.json { head :no_content }
    end
  end

  #用户负责门店
  def manage_store
    begin
      op = params[:op] #add 添加  ,remove 移除
      store_id = params[:store_id]
      @user = User.find(params[:user_id])
      object_store_id = BSON::ObjectId(store_id)
      # @current_user = current_user
      if (op=="add")
        @user.add_to_set({"store_ids" => object_store_id})
      else
        @user.pull({"store_ids" => object_store_id})
      end
      respond_to do |format|
        format.json { render json: {"flag" => 1, "msg" => "门店操作成功！"} }
      end
    rescue Exception => e #异常捕获
      puts e.message
      respond_to do |format|
        format.json { render json: {"flag" => 0, "msg" => "门店操作失败，服务器出现异常！"} }
      end
    end
  end

  #管理员用户对普通用户进行密码重置:123456
  def reset_password
    set_user
    @user.password= '123456'
    respond_to do |format|
      begin
        if @user.save
          # format.js {render_js admin_users_path }
          format.json { render json: get_render_json(1, nil, admin_users_path) }
        else
          # format.html { render :new }
          # format.json { render json: @user.errors, status: :unprocessable_entity }
          # format.js {render_js admin_users_path }
          format.json { render json: get_render_json(0, @user.errors.messages) }
        end
      rescue Exception => e
        p e.message
      end
    end
  end

  #点击动作进入修改密码表格
  def modify_loginpasswordForm

  end

  #当前用户修改登录密码(表单形式)
  def modify_loginpassword
    @current_user = current_user
    respond_to do |format|
      if params[:new_password].present? && BCrypt::Password.new(@current_user.encrypted_password)==params[:old_password]
        @current_user.password = params[:new_password]
        if @current_user.save
          format.json { render json: {:flag => 1, :msg => '密码修改成功'} }
        else
          format.json { render json: {:flag => 0, :msg => "密码修改失败,#{@current_user.errors.full_messages.join()}"} }
        end
      else
        format.json { render json: {:flag => 0, :msg => "旧密码错误,请重新输入!"} }
        # format.json { render json: get_render_json(0, nil, "/admin/users/#{@current_user.id}/modify_loginpasswordForm") }
      end
    end
  end


  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:mobile, :password, :password_confirmation, :userinfo_id, :name, :admin, :roles, :email, :step, :audit_desc, :name_condition)
  end

  def auth?
    @app_key = request.headers['appkey']
  end

end
