class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception

  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  before_action :authenticate_user!

  before_action :configure_permitted_parameters, if: :devise_controller?

  # before_action :authenticate_userinfo

  after_filter :track_action

  rescue_from ::Exception, with: :error_occurred

  before_filter :set_platform_userinfo

  protected


  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:mobile])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:mobile])
  end

  def track_action
    ahoy.track "Processed #{controller_name}##{action_name}", request.filtered_parameters
  end

  def append_info_to_payload(payload)
    super
    payload[:request_id] = request.uuid
    payload[:user_id] = current_user.id if current_user
    payload[:visit_id] = ahoy.visit_id # if you use Ahoy
  end

  def error_occurred(exception)

    ahoy.track "exception", {'exception' => exception, 'backtrace' => exception.backtrace}

    if exception.class == Pundit::NotAuthorizedError
      Rails.logger.info "当前权限验证失败！"
      policy_name = exception.policy.class.to_s.underscore
      render_js dashboards_no_permission_path, (t "#{policy_name}.#{exception.query}", scope: "pundit", default: :default)
    else
      raise
    end

  end

  # def authenticate_userinfo
  #   if current_user.step ==1
  #     redirect_to :controller => "userinfos" ,action: "index", :is_redirect_to => true if params[:is_redirect_to].blank?
  #   elsif current_user.step ==3
  #     redirect_to :controller => "userinfos" ,action: "index", :is_redirect_to => true if params[:is_redirect_to].blank?
  #     current_user.step =4
  #   end
  # end

  def authenticate_user!
    token, options = ActionController::HttpAuthentication::Token.token_and_options(request)

    super unless token == 'rbMmEeoH8RxRDyN24PQv'
  end

  def render_js(path, notice = '')

    flash[:notice] = notice if notice.present?
    path += path.include?("?") ? "&hash_rand=#{rand(1000)}" : "?hash_rand=#{rand(1000)}"
    render :text => "location.hash = '##{path}'"
  end


  def stringParseDate(string)
    begin
      date = Date.strptime(string, '%m/%d/%Y')
    rescue
      date = Time.now.to_date
    end
    return date
  end

  def get_render_json(flag, data={}, path='')
    result={}
    result['flag'] = flag
    result['data'] = data

    if path.present?
      path += path.include?("?") ? "&hash_rand=#{rand(1000)}" : "?hash_rand=#{rand(1000)}"
      result['path'] = "location.hash = '##{path}'"
    end
    result
  end

  #【obj=对象，path=跳转路径】
  #获取对象保存操作的json信息[flag:标识（1成功、0失败），msg:信息提示，error_attrs:对象错误的属性值，path：要跳转的路径]
  def get_render_common_json(obj=nil, path='')
    result={}
    flag = 1 #标识
    #对象名称
    if obj.present?
      result['model'] = underline_tranfer(obj.class.to_s)
      result['msg'] = obj.errors.full_messages
      result['error_attrs'] = obj.errors.messages.keys
      flag = 0 if obj.errors.count > 0
    end
    result['flag'] = flag
    if path.present?
      path += path.include?("?") ? "&hash_rand=#{rand(1000)}" : "?hash_rand=#{rand(1000)}"
      result['path'] = "location.hash = '##{path}'"
    end
    result
  end

  def underline_tranfer(str)
    str.gsub!(/[A-Z]/) { |match|
      "_#{match}"
    }
    str.downcase!
    str[1, str.length]
  end

  def set_platform_userinfo
    @platform_userinfo = Userinfo.where({:role_marks => 'platform'}).cache.first
  end



  # obj model对象
  # path 表单提交后，跳转的路径
  # notice  验证成功后提示
  def render_js_for_form(obj, path='', notice='')

    flash[:notice] = notice if notice.present?
    result={:error_msgs => [], :error_attrs => [], :redirect_path => '', :model => ''}
    result[:model] = underline_tranfer(obj.class.to_s)
    result[:error_msgs] = obj.errors.full_messages
    result[:error_attrs] = obj.errors.messages.keys
    if path.present?
      path += path.include?("?") ? "&hash_rand=#{rand(1000)}" : "?hash_rand=#{rand(1000)}"
      result[:redirect_path] = "location.hash = '##{path}'"
    end
    render :text => "jyd_form_validate(#{result.to_json});"
  end

  def current_userinfo
    @userinfo ||=current_user.userinfo
  end

  private
  def user_not_authorized(exception)
    Rails.logger.info "当前权限验证失败222！"
    policy_name = exception.policy.class.to_s.underscore
    render_js dashboards_no_permission_path, (t "#{policy_name}.#{exception.query}", scope: "pundit", default: :default)
  end
end
