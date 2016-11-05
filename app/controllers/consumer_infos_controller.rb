class ConsumerInfosController < ApplicationController
  before_action :set_consumer_info, only: [:show, :edit, :update, :destroy]

  # GET /consumer_infos
  # GET /consumer_infos.json
  def index
    respond_to do |format|
      format.html
      format.json { render json: ConsumerInfosDatatable.new(view_context, current_user) }
    end
  end

  # GET /consumer_infos/1
  # GET /consumer_infos/1.json
  def show
    @operation = 'show'
  end

  # GET /consumer_infos/new
  def new
    @consumer_info = ConsumerInfo.new
  end

  # GET /consumer_infos/1/edit
  def edit
  end

  # POST /consumer_infos
  # POST /consumer_infos.json
  def create
    @consumer_info = ConsumerInfo.new(consumer_info_params)

    respond_to do |format|
      if @consumer_info.save

        format.js { render_js_for_form @consumer_info, consumer_infos_path, '客户信息新建成功！' }
      else
        format.js  {render_js_for_form @consumer_info}
      end
    end
  end

  # PATCH/PUT /consumer_infos/1
  # PATCH/PUT /consumer_infos/1.json
  def update
    respond_to do |format|
      if @consumer_info.update(consumer_info_params)
        format.js { render_js_for_form @consumer_info, consumer_infos_path, '客户信息新建成功！' }
      else
        format.html { render :edit }
        format.json { render json: @consumer_info.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /consumer_infos/1
  # DELETE /consumer_infos/1.json
  def destroy
    @consumer_info.destroy
    respond_to do |format|
      format.js { render_js_for_form @consumer_info, consumer_infos_path, '客户信息已删除！' }
      # format.html { redirect_to consumer_infos_url, notice: '客户信息已删除.' }
      # format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_consumer_info
      @consumer_info = ConsumerInfo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def consumer_info_params
      params.require(:consumer_info).permit(:name,:birthday,:identity_card,:address,:mobile,:picture)
    end
end
