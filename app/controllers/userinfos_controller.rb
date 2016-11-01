class UserinfosController < ApplicationController
  before_action :set_userinfo, only: [:show, :edit, :update, :destroy]

  # GET /userinfos
  # GET /userinfos.json
  def index
    respond_to do |format|
      format.html
      format.json { render json: UserinfoDatatable.new(view_context, current_user) }
    end
  end

  #权限分配跳转表格
  def jyd_roles_form

    @user_info = Userinfo.find(params[:userinfo_id]) if params[:userinfo_id].present? ##小B的信息
    @roles_id = []
    if @user_info.role_ids.size() > 0 ##小B的所有权限
      @roles_id = @user_info.role_ids
      # else
      #   @user = User.where({:mobile => @user_info.pusher_phone}).first() ##新建小B初始化的用户=>初始化用户有初始化的权限
      #   @user.role_ids.each do |role_id|
      #     @roles_id = role_id.to_s
      #   end
    end
    @roles = Role.where({"role_mark" => "business"}).order('sequence desc') ##角色暴露给页面展示
    @action = "jyd_roles_set" ##提交表单跳转标识
  end

  #权限分配保存操作
  def jyd_roles_set
    user_info = Userinfo.find(params[:user_info][:id]) if params[:user_info][:id].present? ##查询小B信息
    user_info.role_ids = params[:userinfo][:roles] if params[:userinfo].present? ##接受设置小B的角色
    init_user = user_info.users.where(:user_flag => 1).first ##查询小B的一个初始化用户 user_flag = 1 表示初始化用户
    init_user.role_ids = user_info.role_ids ##初始化用户权限与小B权限同步
    init_user.save ##持久化初始化用户
    respond_to do |format|
      if user_info.save ##持久化小B
        format.js { render_js userinfos_path, '单位权限分配成功.' }
      end
    end
  end

  # GET /userinfos/1
  # GET /userinfos/1.json
  #单位详情
  def show
    @userinfo_roles = Role.where({"_id" => {"$in" => @userinfo.role_ids}}) ##查询单位小B 所拥有的权限,作为实例变量用于页面展示
  end

  # GET /userinfos/new
  def new

    @parent_id = params[:parent_id].present? ? params[:parent_id] : '0'
    @userinfo = Userinfo.new
    authorize @userinfo
  end

  # GET /userinfos/1/edit
  def edit

    authorize @userinfo
  end

  # POST /userinfos
  # POST /userinfos.json
  def create

    @userinfo = Userinfo.new(userinfo_params)
    authorize @userinfo
    @userinfo.role_marks = ['business']
    respond_to do |format|
      if @userinfo.save
        format.js { render_js_for_form @userinfo, userinfo_path(@userinfo), '保存成功' }
      else
        format.js { render_js_for_form @userinfo }
      end
    end
  end

  # PATCH/PUT /userinfos/1
  # PATCH/PUT /userinfos/1.json
  def update

    #验证权限
    authorize @userinfo
    respond_to do |format|
      if @userinfo.update(userinfo_params)
        format.js { render_js_for_form @userinfo, userinfo_path(@userinfo), '保存成功' }
      else
        format.js { render_js_for_form @userinfo }
      end
    end
  end


  # DELETE /userinfos/1
  # DELETE /userinfos/1.json
  def destroy
    # @userinfo.destroy
    respond_to do |format|
      format.html { redirect_to userinfos_url, notice: 'Userinfo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  #单位启用
  def jyd_check
    @userinfo = Userinfo.find(params[:userinfo_id])
    #验证权限
    authorize @userinfo
    if @userinfo.users.where(:user_flag => 1).present?
      init_user = @userinfo.users.where(:user_flag => 1).first
    else
      init_user = @userinfo.users.build();
      init_user.name = @userinfo.name
      init_user.email = @userinfo.email
      init_user.step = 9
      init_user.user_flag =1
    end
    init_user.mobile = @userinfo.mobile
    init_user.role_ids = []
    @userinfo.status=1
    if @userinfo.users.present?
      @userinfo.users.each do |user|
        user.password = '123456'
        user.save
      end
    end
    respond_to do |format|
      data = {}
      if init_user.save && @userinfo.save
        data['flag'] = 1
        data['message'] = '启用成功！'
      else
        data['flag'] = 0
        data['message'] = '启用失败！'
      end
      format.json { render json: data }
    end
  end

  #单位停用
  def jyd_check_out
    @userinfo = Userinfo.find(params[:userinfo_id])
    #验证权限
    authorize @userinfo
    @userinfo.status= -1
    if @userinfo.users.size() > 0
      @userinfo.users.each do |user|
        user.password = '654321'
        user.save
      end
    end
    respond_to do |format|
      data = {}
      if @userinfo.save
        data['flag'] = 1
        data['message'] = '停用成功！'
      else
        data['flag'] = 0
        data['message'] = '停用失败！'
      end
      format.json { render json: data }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_userinfo
    @userinfo = Userinfo.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def userinfo_params

    params.require(:userinfo).permit(:name, :shopname, :idnumber, :mobile, :email, :remark, :role_marks, :status)
  end

end
