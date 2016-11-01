class CashPurchasesController < ApplicationController
  before_action :set_cash_purchase, only: [:show, :edit, :update, :destroy]

  # GET /cash_purchases
  # GET /cash_purchases.json
  def index
    @cash_purchases = CashPurchase.all
  end

  # GET /cash_purchases/1
  # GET /cash_purchases/1.json
  def show
  end

  # GET /cash_purchases/new
  def new
    @cash_purchase = CashPurchase.new
  end

  # GET /cash_purchases/1/edit
  def edit
  end

  # POST /cash_purchases
  # POST /cash_purchases.json
  def create
    @cash_purchase = CashPurchase.new(cash_purchase_params)

    respond_to do |format|
      if @cash_purchase.save
        format.html { redirect_to @cash_purchase, notice: 'Cash purchase was successfully created.' }
        format.json { render :show, status: :created, location: @cash_purchase }
      else
        format.html { render :new }
        format.json { render json: @cash_purchase.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cash_purchases/1
  # PATCH/PUT /cash_purchases/1.json
  def update
    respond_to do |format|
      if @cash_purchase.update(cash_purchase_params)
        format.html { redirect_to @cash_purchase, notice: 'Cash purchase was successfully updated.' }
        format.json { render :show, status: :ok, location: @cash_purchase }
      else
        format.html { render :edit }
        format.json { render json: @cash_purchase.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cash_purchases/1
  # DELETE /cash_purchases/1.json
  def destroy
    @cash_purchase.destroy
    respond_to do |format|
      format.html { redirect_to cash_purchases_url, notice: 'Cash purchase was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cash_purchase
      @cash_purchase = CashPurchase.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cash_purchase_params
      params.fetch(:cash_purchase, {})
    end
end
