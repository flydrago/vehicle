class DistriProductInfosController < ApplicationController
  before_action :set_distri_product_info, only: [:show, :edit, :update, :destroy]

  # GET /distri_product_infos
  # GET /distri_product_infos.json
  def index
    @distri_product_infos = DistriProductInfo.all
  end

  # GET /distri_product_infos/1
  # GET /distri_product_infos/1.json
  def show
  end

  # GET /distri_product_infos/new
  def new
    @distri_product_info = DistriProductInfo.new
  end

  # GET /distri_product_infos/1/edit
  def edit
  end

  # POST /distri_product_infos
  # POST /distri_product_infos.json
  def create
    @distri_product_info = DistriProductInfo.new(distri_product_info_params)

    respond_to do |format|
      if @distri_product_info.save
        format.html { redirect_to @distri_product_info, notice: 'Distri product info was successfully created.' }
        format.json { render :show, status: :created, location: @distri_product_info }
      else
        format.html { render :new }
        format.json { render json: @distri_product_info.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /distri_product_infos/1
  # PATCH/PUT /distri_product_infos/1.json
  def update
    respond_to do |format|
      if @distri_product_info.update(distri_product_info_params)
        format.html { redirect_to @distri_product_info, notice: 'Distri product info was successfully updated.' }
        format.json { render :show, status: :ok, location: @distri_product_info }
      else
        format.html { render :edit }
        format.json { render json: @distri_product_info.errors, status: :unprocessable_entity }
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
      params.require(:distri_product_info).permit(:product_name, :product_price)
    end
end
