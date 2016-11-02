class VehicleinfosController < ApplicationController
  before_action :set_vehicleinfo, only: [:show, :edit, :update, :destroy]

  # GET /vehicleinfos
  # GET /vehicleinfos.json
  def index
    respond_to do |format|
      format.html
      format.json { render json: VehicleInfoDatatable.new(view_context, current_user) }
    end
  end

  # GET /vehicleinfos/1
  # GET /vehicleinfos/1.json
  def show
    @operation = 'show'
  end

  # GET /vehicleinfos/new
  def new
    @vehicleinfo = Vehicleinfo.new
    @action = "create"
  end

  # GET /vehicleinfos/1/edit
  def edit
    @action = "update"
  end

  # POST /vehicleinfos
  # POST /vehicleinfos.json
  def create
    @vehicleinfo = Vehicleinfo.new(vehicleinfo_params)

    respond_to do |format|
      if @vehicleinfo.save
        format.js { render_js_for_form @vehicleinfo,vehicleinfos_path, '创建成功!' }
      else
        format.js { render_js_for_form @vehicleinfo }
      end
    end
  end

  # PATCH/PUT /vehicleinfos/1
  # PATCH/PUT /vehicleinfos/1.json
  def update
    respond_to do |format|
      if @vehicleinfo.update(vehicleinfo_params)
        format.js { render_js_for_form @vehicleinfo,vehicleinfos_path, '修改成功!' }
      else
        format.js { render_js_for_form @vehicleinfo }
      end
    end
  end

  # DELETE /vehicleinfos/1
  # DELETE /vehicleinfos/1.json
  def destroy
    @vehicleinfo.destroy
    respond_to do |format|
      format.js { render_js_for_form @vehicleinfo,vehicleinfos_path, '删除成功!' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vehicleinfo
      @vehicleinfo = Vehicleinfo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def vehicleinfo_params
      params.require(:vehicleinfo).permit(:vehicle_brand,:vehicle_name, :vehicle_model,:vehicle_engine_number,:vehicle_color,:vehicle_style)
    end
end
