class QuartosController < ApplicationController
  before_action :set_quarto, only: %i[ show update destroy ]

  # GET /quartos
  def index
    @quartos = Quarto.all

    render json: @quartos
  end

  # GET /quartos/1
  def show
    render json: @quarto
  end

  # POST /quartos
  def create
    @quarto = Quarto.new(quarto_params)

    if @quarto.save
      render json: @quarto, status: :created, location: @quarto
    else
      render json: @quarto.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /quartos/1
  def update
    if @quarto.update(quarto_params)
      render json: @quarto
    else
      render json: @quarto.errors, status: :unprocessable_entity
    end
  end

  # DELETE /quartos/1
  def destroy
    @quarto.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quarto
      @quarto = Quarto.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def quarto_params
      params.require(:quarto).permit(:numero, :tipo, :disponibilidade, :preco_diaria, :descricao)
    end
end
