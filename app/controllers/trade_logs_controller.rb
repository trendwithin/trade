class TradeLogsController < ApplicationController
  before_action :set_trade_log, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  after_action :verify_authorized

  # GET /trade_logs
  # GET /trade_logs.json
  def index
    @trade_logs = TradeLog.all
    authorize @trade_logs
  end

  # GET /trade_logs/1
  # GET /trade_logs/1.json
  def show
  end

  # GET /trade_logs/new
  def new
    @trade_log = TradeLog.new
    authorize @trade_log
  end

  # GET /trade_logs/1/edit
  def edit
  end

  # POST /trade_logs
  # POST /trade_logs.json
  def create
    @trade_log = TradeLog.new(trade_log_params)
    authorize @trade_log
    respond_to do |format|
      if @trade_log.save
        format.html { redirect_to @trade_log, notice: 'Trade log was successfully created.' }
        format.json { render :show, status: :created, location: @trade_log }
      else
        format.html { render :new }
        format.json { render json: @trade_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trade_logs/1
  # PATCH/PUT /trade_logs/1.json
  def update
    respond_to do |format|
      if @trade_log.update(trade_log_params)
        authorize @trade_log
        format.html { redirect_to @trade_log, notice: 'Trade log was successfully updated.' }
        format.json { render :show, status: :ok, location: @trade_log }
      else
        format.html { render :edit }
        format.json { render json: @trade_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trade_logs/1
  # DELETE /trade_logs/1.json
  def destroy
    @trade_log.destroy
    respond_to do |format|
      format.html { redirect_to trade_logs_url, notice: 'Trade log was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trade_log
      @trade_log = TradeLog.find(params[:id])
      authorize @trade_log
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def trade_log_params
      params.require(:trade_log).permit(:user_id, :trade_opened_at, :symbol, :position_size, :entry_price, :stop, :exit_one_on, :exit_one_shares, :exit_one_price, :exit_two_on, :exit_two_shares, :exit_two_price, :exit_three_on, :exit_three_shares, :exit_three_price)
    end
end
