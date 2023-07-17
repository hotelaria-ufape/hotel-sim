class ReservasController < ApplicationController
  before_action :set_reserva, only: %i[ show edit update destroy ]

  # GET /reservas or /reservas.json
  def index
    @reservas = Reserva.all
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

    # Calcular o custo com base no quarto e dias de hospedagem
    quarto = Quarto.find(reserva_params[:quarto_id])
    data_entrada = Date.parse(reserva_params[:data_de_entrada])
    data_saida = Date.parse(reserva_params[:data_de_saida])
    dias_hospedagem = (data_saida - data_entrada).to_i
    custo = quarto.preco_diaria * dias_hospedagem

    # Definir o custo no objeto reserva
    @reserva.custo = custo

    respond_to do |format|
      if @reserva.save
        format.html { redirect_to reserva_url(@reserva), notice: "Reserva was successfully created." }
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
        format.html { redirect_to reserva_url(@reserva), notice: "Reserva was successfully updated." }
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
      format.html { redirect_to reservas_url, notice: "Reserva was successfully destroyed." }
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
