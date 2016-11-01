class UsersDatatable
  delegate :params, :session, :raw, :link_to, :number_to_currency, :best_in_place, to: :@view

  def initialize(view, current_user)
    @view = view
    @current_user = current_user
  end

  def as_json(options = {})
    {
        sEcho: params[:sEcho].to_i,
        iTotalRecords: fetch_data_count,
        iTotalDisplayRecords: fetch_data_count,
        aaData: data
    }
  end

  private
  def data
    get_datas.map do |data|
      rows = []
      rows << data.name
      rows << data.mobile
      rows << data.created_at.strftime("%Y-%m-%d %H:%M:%S")
      if @current_user.has_role?(:system_management) || @current_user.has_role?(:SuperAdmin)
        if data.user_flag==0 && @current_user.id!= data.id
          rows << raw("<div class='hidden-sm hidden-xs action-buttons'>
          <a class='btn btn-xs btn-info' data-url='#{@view.admin_user_path(data)}' href='##{@view.admin_user_path(data)}'>查看</a>
          <a class='btn btn-xs btn-info' data-url='#{@view.edit_admin_user_path(data)}' href='##{@view.edit_admin_user_path(data)}'>
                <i class='ace-icon fa fa-pencil bigger-130'>编辑</i>
          </a>
          <a class='btn btn-xs btn-danger' data-confirm='你确定重置用户密码吗?' href=\"javascript:reset_password('"+data.id+"')\">密码重置</a>
          <a class='btn btn-xs btn-danger'  data-method='delete' data-remote='true' data-confirm='你确定删除吗?' href='/admin/users/#{data.id}'>删除</a>
         </div>")
        else
          rows << raw("<div class='hidden-sm hidden-xs action-buttons'>
          <a class='btn btn-xs btn-info' data-url='#{@view.admin_user_path(data)}' href='##{@view.admin_user_path(data)}'>查看</a>
          <a class='btn btn-xs btn-info' data-url='#{@view.edit_admin_user_path(data)}' href='##{@view.edit_admin_user_path(data)}'>
                <i class='ace-icon fa fa-pencil bigger-130'>编辑</i>
          </a>
          <a class='btn btn-xs btn-danger' data-confirm='你确定重置用户密码吗?' href=\"javascript:reset_password('"+data.id+"')\">密码重置</a>
         </div>")
        end
      else
        rows << raw("<div class='hidden-sm hidden-xs action-buttons'>
          <a class='btn btn-xs btn-info' data-url='#{@view.edit_admin_user_path(data)}' href='##{@view.edit_admin_user_path(data)}'>
                <i class='ace-icon fa fa-pencil bigger-130'>编辑</i>
          </a>
         </div>")
      end
      rows
    end
  end

  def get_datas
    @datas ||= fetch_datas
  end

  def fetch_datas

    data_array = []
    User.where(get_search_params).order("#{sort_column} #{sort_direction}").page(page).per(per_page).each do |data|
      data_array << data
    end
    data_array
  end

  def fetch_data_count

    @data_count ||= User.where(get_search_params).count
  end

  def get_search_params
    search_params = {}

    search_params[:userinfo_id] = @current_user['userinfo_id']
    search_params[:mobile] = /#{params[:mobile]}/ if params[:mobile].present?
    search_params[:name] = /#{params[:sSearch]}/ if params[:sSearch].present?


    search_params
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 25
  end

  def sort_column
    columns = %w(name mobile created_at caozuo)
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end