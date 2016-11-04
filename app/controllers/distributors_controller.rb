class DistributorsController < ApplicationController
  before_action :set_distributor, only: [:show, :edit, :update, :destroy]

  # GET /distributors
  # GET /distributors.json
  def index
    respond_to do |format|
      format.html
      format.json { render json: DistributorDatatable.new(view_context, current_user) }
    end
  end

  # GET /distributors/1
  # GET /distributors/1.json
  def show
    @operation = "show"
  end

  # GET /distributors/new
  def new
    @distributor = Distributor.new
    @action = "create"
  end

  # GET /distributors/1/edit
  def edit
    @action = "update"
  end

  # POST /distributors
  # POST /distributors.json
  def create
    @distributor = Distributor.new(distributor_params)

    respond_to do |format|
      if @distributor.save
        format.js { render_js_for_form @distributor,distributors_path, '创建成功!' }
      else
        format.js { render_js_for_form @distributor }
      end
    end
  end

  # PATCH/PUT /distributors/1
  # PATCH/PUT /distributors/1.json
  def update
    respond_to do |format|
      if @distributor.update(distributor_params)
        format.js { render_js_for_form @distributor,distributors_path, '修改成功!' }
      else
        format.js { render_js_for_form @distributor }
      end
    end
  end

  # DELETE /distributors/1
  # DELETE /distributors/1.json
  def destroy
    @distributor.destroy
    respond_to do |format|
      format.js { render_js_for_form @distributor,distributors_path, '删除成功!' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_distributor
      @distributor = Distributor.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def distributor_params
      params.require(:distributor).permit(:distributor_name,:contact_name,:phone_number,:distributor_address)
    end
end
