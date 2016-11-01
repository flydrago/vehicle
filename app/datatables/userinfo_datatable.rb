class UserinfoDatatable
  delegate :params, :session, :raw, :link_to, :number_to_currency, :best_in_place, to: :@view

  def initialize(view, current_user)
    @view = view
    @current_user = current_user
  end

  def as_json(options = {})

    fetch_data_count = Userinfo.where(get_search_params).count

    {
        sEcho: params[:sEcho].to_i,
        iTotalRecords: fetch_data_count,
        iTotalDisplayRecords: fetch_data_count,
        aaData: data
    }
  end

  private

  def data

    Userinfo.where(get_search_params).order("#{sort_column} #{sort_direction}").page(page).per(per_page).map do |data|
      [
          data.shopname,
          data.name,
          data.mobile,
          data.idnumber,
          data.email,
          data.created_at ==nil  ? "" : data.created_at.strftime("%Y-%m-%d %H:%M:%S") ,
          data.status_str,
          %Q{
          #{link_to('详细', "##{@view.userinfo_path(data)}", class: 'btn btn-minier')+raw("&nbsp;&nbsp;")}
          #{link_to('修改', "##{@view.edit_userinfo_path(data)}", class: 'btn btn-minier')+raw("&nbsp;&nbsp;")}
          #{(data.status==0||data.status==-1) ? raw("
          <a class='btn btn-minier btn-primary' data-url='' data-disable-with='处理中...' href='javascript:jyd_check(\"#{data.id}\");'>启用</a>") : raw("
          <a class='btn btn-minier btn-warning' data-url='' data-disable-with='处理中...' href='javascript:jyd_check_out(\"#{data.id}\");'>停用</a>")}
          #{(data.status==1) ? link_to('权限设置', "#/userinfos/jyd_roles_form/#{data.id}", class: 'btn btn-minier btn-warning')+raw("&nbsp;&nbsp;") : ''}
          }
      ]
    end

  end

  def get_search_params

    shopname = params[:shopname].present? ? params[:shopname] : params[:sSearch]
    name = params[:name]
    mobile = params[:mobile]
    status = params[:status]
    beginTime = params[:beginTime]
    endTime = params[:endTime]

    search_params = {:role_marks => "business"}
    search_params[:shopname] = /#{shopname}/ if shopname.present?
    search_params[:name] = /#{name}/ if name.present?
    search_params[:mobile] = /#{mobile}/ if mobile.present?
    search_params[:status] = status.to_i if status.present?
    search_params[:created_at.gte] = Time.zone.parse("#{beginTime}") if beginTime.present?
    search_params[:created_at.lte] = Time.zone.parse("#{endTime}") if endTime.present?
    search_params

  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 25
  end

  def sort_column
    columns = %w[id shopname name created_at pusher_phone store_numbers created_at status created_at]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end

end

