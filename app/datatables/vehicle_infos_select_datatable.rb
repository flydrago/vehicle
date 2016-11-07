class VehicleInfosSelectDatatable
  delegate :params, :session, :raw, :link_to, :number_to_currency, :best_in_place, to: :@view

  def initialize(view, current_user)
    @view = view
    @current_user = current_user
  end

  def as_json(options = {})
    {
        draw: params[:draw].to_i,
        recordsTotal: fetch_data_count,
        recordsFiltered: fetch_data_count,
        aaData: data
    }
  end

  private
  def data

    Vehicleinfo.where(get_search_params).order("#{sort_column} #{sort_direction}").page(page).per(per_page).map do |data|
      {:id => data.id.to_s,
       :vehicle_brand => data.vehicle_brand,
       :vehicle_name => data.vehicle_name,
       :vehicle_model => data.vehicle_model,
       :vehicle_engine_number => data.vehicle_engine_number,
       :vehicle_color => data.vehicle_color,
       :vehicle_style => data.vehicle_style
      }
    end
  end

  def fetch_data_count

    @data_count ||= Vehicleinfo.where(get_search_params).count
  end

  def get_search_params

    sSearch = params[:sSearch]
    search_params = {:userinfo_id => @current_user['userinfo_id']}
    search_params['$or'] = [{:vehicle_brand => /#{sSearch}/}, {:vehicle_name => /#{sSearch}/}, {:vehicle_model => /#{sSearch}/}, {:vehicle_engine_number => /#{sSearch}/}, {:vehicle_color => /#{sSearch}/}, {:vehicle_style => /#{sSearch}/}] if sSearch.present?
    search_params
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 25
  end

  def sort_column
    columns = %w[vehicle_brand vehicle_name vehicle_model vehicle_engine_number vehicle_color vehicle_style]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end