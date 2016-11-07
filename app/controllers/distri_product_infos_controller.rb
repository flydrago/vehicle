class DistriProductInfosController < ApplicationController
  before_action :set_distri_product_info, only: [:show, :edit, :update, :destroy]

  # GET /distri_product_infos
  # GET /distri_product_infos.json
  def index
    @distributor_id = params[:distributor_id] if params[:distributor_id].present?
    session[:distributor_id] = @distributor_id if @distributor_id.present?
    @distributor = Distributor.find(@distributor_id)  if @distributor_id.present?
    respond_to do |format|
      format.html
      format.json { render json: DistriProductInfoDatatable.new(view_context, current_user) }
    end
  end

  # GET /distri_product_infos/1
  # GET /distri_product_infos/1.json
  def show
    @operation = "show"
    @distributor = Distributor.find(session[:distributor_id])
  end

  # GET /distri_product_infos/new
  def new
    @distributor = Distributor.find(session[:distributor_id])
    @distri_product_info = DistriProductInfo.new
    @action = "create"
  end

  # GET /distri_product_infos/1/edit
  def edit
    @distributor = Distributor.find(session[:distributor_id])
    @action = "update"
  end

  # POST /distri_product_infos
  # POST /distri_product_infos.json
  def create
    @distri_product_info = DistriProductInfo.new(distri_product_info_params)
    @distri_product_info.distributor = Distributor.find(session[:distributor_id])
    respond_to do |format|
      if @distri_product_info.save
        format.js { render_js "/distributors/#{@distri_product_info.distributor_id}/distri_product_infos", '创建成功!' }
      else
        # format.js { render_js_for_form @distri_product_info }
      end
    end
  end

  # PATCH/PUT /distri_product_infos/1
  # PATCH/PUT /distri_product_infos/1.json
  def update
    respond_to do |format|
      if @distri_product_info.update(distri_product_info_params)
        format.js { render_js "/distributors/#{session[:distributor_id]}/distri_product_infos", '修改成功!' }
      else
        # format.js { render_js_for_form @distri_product_info }
      end
    end
  end

  # DELETE /distri_product_infos/1
  # DELETE /distri_product_infos/1.json
  def destroy
    @distri_product_info.destroy
    respond_to do |format|
      format.html { redirect_to distri_product_infos_url, notice: 'Distri product info was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_distri_product_info
      @distri_product_info = DistriProductInfo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def distri_product_info_params
      params.require(:distri_product_info).permit(:product_name, :product_model,:product_price,:product_count,:should_get_money,:real_get_money)
    end
end
