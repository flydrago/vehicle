class DistributorDatatable
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
        rows << data.distributor_name
        rows << data.contact_name
        rows << data.phone_number
        rows << data.distributor_address
        rows << data.created_at.strftime("%Y-%m-%d %H:%M:%S")
        rows << raw("<div class='hidden-sm hidden-xs action-buttons'>
          <a class='btn btn-xs btn-info' data-url='#{@view.distributor_path(data)}' href='##{@view.distributor_path(data)}'>查看</a>
          <a class='btn btn-xs btn-info' data-url='#{@view.edit_distributor_path(data)}' href='##{@view.edit_distributor_path(data)}'>
                <i class='ace-icon fa fa-pencil bigger-130'>编辑</i>
          </a>
          <a class='btn btn-xs btn-danger'  data-method='delete' data-remote='true' data-confirm='你确定删除吗?' href='/distributors/#{data.id}'>删除</a>
         </div>")
        rows
      end
    end

    def get_datas
      @datas ||= fetch_datas
    end

    def fetch_datas

      data_array = []
      Distributor.where(get_search_params).order("#{sort_column} #{sort_direction}").page(page).per(per_page).each do |data|
        data_array << data
      end
      data_array
    end

    def fetch_data_count

      @data_count ||= Distributor.where(get_search_params).count
    end

    def get_search_params
      search_params = {}

      # search_params[:userinfo_id] = @current_user['userinfo_id']
      search_params[:distributor_name] = /#{params[:distributor_name]}/ if params[:distributor_name].present?
      search_params[:contact_name] = /#{params[:contact_name]}/ if params[:contact_name].present?
      search_params[:phone_number] = /#{params[:phone_number]}/ if params[:phone_number].present?
      search_params[:distributor_address] = /#{params[:distributor_address]}/ if params[:distributor_address].present?
      search_params[:distributor_name] = /#{params[:sSearch]}/ if params[:sSearch].present?
      search_params
    end

    def page
      params[:iDisplayStart].to_i/per_page + 1
    end

    def per_page
      params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 25
    end

    def sort_column
      columns = %w(distributor_name contact_name phone_number distributor_address  created_at caozuo)
      columns[params[:iSortCol_0].to_i]
    end

    def sort_direction
      params[:sSortDir_0] == "desc" ? "desc" : "asc"
    end
end