class ReservasController < ApplicationController
  before_action :set_reserva, only: %i[ show update destroy ]

  # GET /reservas
  def index
    @reservas = Reserva.all

    render json: @reservas
  end

  # GET /reservas/1
  def show
    render json: @reserva
  end

  # POST /reservas
  def create
    @reserva = Reserva.new(reserva_params)

    if @reserva.save
      render json: @reserva, status: :created, location: @reserva
    else
      render json: @reserva.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /reservas/1
  def update
    if @reserva.update(reserva_params)
      render json: @reserva
    else
      render json: @reserva.errors, status: :unprocessable_entity
    end
  end

  # DELETE /reservas/1
  def destroy
    @reserva.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reserva
      current_user = Cliente.find(session[:cliente_id])
      @reserva = current_user.reservas.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def reserva_params
      params.require(:reserva).permit(:cliente_id, :quarto_id, :data_de_entrada, :data_de_saida, :custo)
    end
end
