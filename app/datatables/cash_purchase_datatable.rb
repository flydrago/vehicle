class CashPurchaseDatatable
  delegate :params, :session, :raw, :link_to, :number_to_currency, :best_in_place, to: :@view

  def initialize(view, current_user)
    @view = view
    @current_user = current_user
  end

  def as_json(options = {})
    fetch_data_count = CashPurchase.where(get_search_params).count
    {
        sEcho: params[:sEcho].to_i,
        iTotalRecords: fetch_data_count,
        iTotalDisplayRecords: fetch_data_count,
        aaData: data
    }
  end

  private
  def data
    CashPurchase.where(get_search_params).order("#{sort_column} #{sort_direction}").page(page).per(per_page).map do |data|
      [
          ["雅马哈","凤凰","飞鸽","雅迪","绿佳","小刀"][rand(5)],
          ["H1","H2","H3","H4","H5"][rand(5)],
          ["孙悟空","猪八戒","沙和尚","唐生","白骨精","女儿国国王"][rand(5)],
          ["42172319880705161a","42172319880705161b","42172319880705161c","42172319880705161d","42172319880705161e","42172319880705161f"][rand(5)],
          data.licenseplatenumber,
          data.colour,
          data.motornumber,
          data.enginenumber,
          data.buyingtime.strftime("%Y-%m-%d %H:%M:%S"),
          data.carprice,
          data.scheduledmaintenance.strftime("%Y-%m-%d %H:%M:%S"),
          %Q{
          #{link_to('修改', "##{@view.edit_cash_purchase_path(data)}", class: 'btn btn-minier')+raw("&nbsp;&nbsp;")}
          #{raw("<a class='btn btn-minier btn-primary' data-url='' data-disable-with='处理中...' href='javascript:jyd_check(\"#{data.id}\");'>删除</a>") }
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
    search_params = {:Userinfo => @current_user.userinfo}
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
    columns = %w[id id id id licenseplatenumber colour motornumber enginenumber buyingtime carprice scheduledmaintenance]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end

