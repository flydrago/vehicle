class RolesDatatable
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
      rows << data.name_title
      rows << data.role_mark_str
      rows << data.sequence
      rows << data.created_at.strftime("%Y-%m-%d %H:%M:%S")
      rows << raw("<div class='hidden-sm hidden-xs action-buttons'>
        <a class='btn btn-xs btn-info' href='#/roles/#{data.id}/edit'>
              <i class='ace-icon fa fa-pencil bigger-130'>编辑</i>
        </a>
        <a class='btn btn-xs btn-danger'  data-method='delete' data-remote='true' data-confirm='你确定删除吗?' href='/roles/#{data.id}'>删除</a>
      </div>")
      rows
    end
  end

  def get_datas
    @datas ||= fetch_datas
  end

  def fetch_datas

    data_array = []
    Role.where(get_search_params).order("#{sort_column} #{sort_direction}").page(page).per(per_page).each do |data|
      data_array << data
    end
    data_array

  end

  def fetch_data_count

    @data_count ||= Role.where(get_search_params).count
  end

  def get_search_params
    search_params = {}
    search_params[:name] = /#{params[:sSearch]}/ if params[:sSearch].present?
    search_params[:name_title] = /#{params[:name_title]}/ if params[:name_title].present?
    search_params[:role_mark] = params[:role_mark].present? ? params[:role_mark] : {"$in"=>['business','platform']}
    search_params
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 25
  end

  def sort_column
    columns = %w(name name_title role_mark_str sequence created_at operation)
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end