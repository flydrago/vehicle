class SupplyProductInfosController < ApplicationController
  before_action :set_supply_product_info, only: [:show, :edit, :update, :destroy]

  # GET /supply_product_infos
  # GET /supply_product_infos.json
  def index
    @supplier_id=params[:supplier_id] if params[:supplier_id].present?
    session[:supplier_id] = @supplier_id if @supplier_id.present?
    respond_to do |format|
      format.html
      format.json { render json: SupplyProductInfosDatatable.new(view_context, current_user) }
    end
  end

  # GET /supply_product_infos/1
  # GET /supply_product_infos/1.json
  def show
    @operation = 'show'
  end

  # GET /supply_product_infos/new
  def new
    @supply_product_info = SupplyProductInfo.new
    @supplier=Supplier.find(session[:supplier_id])
    @action = "create"
  end

  # GET /supply_product_infos/1/edit
  def edit
    @action = "update"
  end

  # POST /supply_product_infos
  # POST /supply_product_infos.json
  def create
    @supply_product_info = SupplyProductInfo.new(supply_product_info_params)

    respond_to do |format|
      if @supply_product_info.save
        format.js { render_js "/suppliers/#{@supply_product_info.supplier_id}/supply_product_infos", '供货信息新建成功!' }
      else
        format.html { render :new }
        format.json { render json: @supply_product_info.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /supply_product_infos/1
  # PATCH/PUT /supply_product_infos/1.json
  def update
    respond_to do |format|
      if @supply_product_info.update(supply_product_info_params)
        format.js { render_js "/suppliers/#{@supply_product_info.supplier_id}/supply_product_infos", '供货信息更新成功!' }
      else
        format.html { render :edit }
        format.json { render json: @supply_product_info.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /supply_product_infos/1
  # DELETE /supply_product_infos/1.json
  def destroy
    @supply_product_info.destroy
    respond_to do |format|
      format.js { render_js "/suppliers/#{@supply_product_info.supplier_id}/supply_product_infos", '供货信息删除成功!' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_supply_product_info
      @supply_product_info = SupplyProductInfo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def supply_product_info_params
      params.require(:supply_product_info).permit(:purchasePrice, :count, :payable_money, :payreal_money,:license_plate_number)
    end
end
