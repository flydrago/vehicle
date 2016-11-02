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
  end

  # GET /vehicleinfos/new
  def new
    @vehicleinfo = Vehicleinfo.new
    @action = "create"
  end

  # GET /vehicleinfos/1/edit
  def edit
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
        format.html { redirect_to @vehicleinfo, notice: 'Vehicleinfo was successfully updated.' }
        format.json { render :show, status: :ok, location: @vehicleinfo }
      else
        format.html { render :edit }
        format.json { render json: @vehicleinfo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vehicleinfos/1
  # DELETE /vehicleinfos/1.json
  def destroy
    @vehicleinfo.destroy
    respond_to do |format|
      format.html { redirect_to vehicleinfos_url, notice: 'Vehicleinfo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vehicleinfo
      @vehicleinfo = Vehicleinfo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def vehicleinfo_params
      params.require(:vehicleinfo).permit(:vehicle_brand,:vehicle_name, :vehicle_model,:vehicle_style)
    end
end
