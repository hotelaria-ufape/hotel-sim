class ReservasController < ApplicationController
  before_action :set_reserva, only: %i[ show edit update destroy ]

  # GET /reservas or /reservas.json
  def index
    @reservas = Reserva.all

    if params[:attribute] == "date" && params[:start_date].present? && params[:end_date].present?
      start_date = DateTime.parse(params[:start_date])
      end_date = DateTime.parse(params[:end_date])
      @reservas = @reservas.where("(data_de_entrada BETWEEN ? AND ?) OR (data_de_saida BETWEEN ? AND ?)", start_date, end_date, start_date, end_date)
    elsif params[:attribute] == "cost" && params[:min_cost].present? && params[:max_cost].present?
      min_cost = params[:min_cost].to_f
      max_cost = params[:max_cost].to_f
      @reservas = @reservas.where(custo: min_cost..max_cost)
    end
  end

  # GET /reservas/1 or /reservas/1.json
  def show
  end

  # GET /reservas/new
  def new
    @reserva = Reserva.new
  end

  def get_custo
    quarto = Quarto.find(params[:quarto_id])
    custo = quarto.preco_diaria # Ou qualquer lógica que você tenha para calcular o custo

    render json: { custo: custo }
  end

  # GET /reservas/1/edit
  def edit
  end

  # POST /reservas or /reservas.json
  def create
    @reserva = Reserva.new(reserva_params)

    respond_to do |format|
      if @reserva.save
        format.html { redirect_to reserva_url(@reserva), notice: "Reserva criada com sucesso." }
        format.json { render :show, status: :created, location: @reserva }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @reserva.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reservas/1 or /reservas/1.json
  def update
    respond_to do |format|
      if @reserva.update(reserva_params)
        format.html { redirect_to reserva_url(@reserva), notice: "Reserva atualizada com sucesso." }
        format.json { render :show, status: :ok, location: @reserva }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @reserva.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reservas/1 or /reservas/1.json
  def destroy
    @reserva.destroy
    respond_to do |format|
      format.html { redirect_to reservas_url, notice: "Reserva destruída com sucesso." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reserva
      @reserva = Reserva.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def reserva_params
      params.require(:reserva).permit(:cliente_id, :quarto_id, :data_de_entrada, :data_de_saida, :custo)
    end
end
