class SupplierDatatable
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
      rows << data.contact_name
      rows << data.mobile
      rows << data.address
      rows << data.created_at.strftime("%Y-%m-%d %H:%M:%S")
      rows << raw("<div class='hidden-sm hidden-xs action-buttons'>
          <a class='btn btn-xs btn-info' data-url='#{@view.supplier_path(data)}' href='##{@view.supplier_path(data)}'>详情</a>
          <a class='btn btn-xs btn-warning' data-url='#{@view.edit_supplier_path(data)}' href='##{@view.edit_supplier_path(data)}'>编辑</a>
          <a class='btn btn-xs btn-success' data-url='#{@view.supplier_supply_product_infos_path(data)}' href='##{@view.supplier_supply_product_infos_path(data)}'>供货信息</a>
          <a class='btn btn-xs btn-danger'  data-method='delete' data-remote='true' data-confirm='你确定删除吗?' href='/suppliers/#{data.id}'>删除</a>
        </div>")
      rows
    end
  end

  def get_datas
    @datas ||= fetch_datas
  end

  def fetch_datas

    data_array = []
    Supplier.where(get_search_params).order("#{sort_column} #{sort_direction}").page(page).per(per_page).each do |data|
      data_array << data
    end
    data_array
  end

  def fetch_data_count

    @data_count ||= Supplier.where(get_search_params).count
  end

  def get_search_params
    search_params = {}
    search_params[:mobile] = params[:mobile] if params[:mobile].present?
    search_params[:name] = params[:name] if params[:name].present?
    search_params[:contact_name] = params[:contact_name] if params[:contact_name].present?
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