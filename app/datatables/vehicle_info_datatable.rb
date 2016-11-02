class VehicleInfoDatatable
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
        rows << data.vehicle_brand
        rows << data.vehicle_name
        rows << data.vehicle_model
        rows << data.vehicle_engine_number
        rows << data.vehicle_color
        rows << data.vehicle_style
        rows << data.created_at.strftime("%Y-%m-%d %H:%M:%S")
        rows << raw("<div class='hidden-sm hidden-xs action-buttons'>
          <a class='btn btn-xs btn-info' data-url='#{@view.vehicleinfo_path(data)}' href='##{@view.vehicleinfo_path(data)}'>查看</a>
          <a class='btn btn-xs btn-info' data-url='#{@view.edit_vehicleinfo_path(data)}' href='##{@view.edit_vehicleinfo_path(data)}'>
                <i class='ace-icon fa fa-pencil bigger-130'>编辑</i>
          </a>
          <a class='btn btn-xs btn-danger'  data-method='delete' data-remote='true' data-confirm='你确定删除吗?' href='/vehicleinfos/#{data.id}'>删除</a>
         </div>")
        rows
      end
    end

    def get_datas
      @datas ||= fetch_datas
    end

    def fetch_datas

      data_array = []
      Vehicleinfo.where(get_search_params).order("#{sort_column} #{sort_direction}").page(page).per(per_page).each do |data|
        data_array << data
      end
      data_array
    end

    def fetch_data_count

      @data_count ||= Vehicleinfo.where(get_search_params).count
    end

    def get_search_params
      search_params = {}

      # search_params[:userinfo_id] = @current_user['userinfo_id']
      search_params[:vehicle_brand] = /#{params[:vehicle_brand]}/ if params[:vehicle_brand].present?
      search_params[:vehicle_name] = /#{params[:vehicle_name]}/ if params[:vehicle_name].present?
      search_params[:vehicle_model] = /#{params[:vehicle_model]}/ if params[:vehicle_model].present?
      search_params[:vehicle_style] = /#{params[:vehicle_style]}/ if params[:vehicle_style].present?
      search_params
    end

    def page
      params[:iDisplayStart].to_i/per_page + 1
    end

    def per_page
      params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 25
    end

    def sort_column
      columns = %w(vehicle_brand vehicle_name vehicle_model vehicle_engine_number vehicle_color vehicle_style created_at caozuo)
      columns[params[:iSortCol_0].to_i]
    end

    def sort_direction
      params[:sSortDir_0] == "desc" ? "desc" : "asc"
    end
end