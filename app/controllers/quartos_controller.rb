class QuartosController < ApplicationController
  before_action :set_quarto, only: %i[ show edit update destroy ]

  # GET /quartos or /quartos.json
  def index
    @quartos = Quarto.all

    if params[:attribute].present? && params[:search].present?
      attribute = params[:attribute]
      search_query = params[:search]

      case attribute
      when "numero"
        @quartos = @quartos.where('numero LIKE ?', "%#{search_query}%")
      when "tipo"
        @quartos = @quartos.where('tipo LIKE ?', "%#{search_query}%")
      when "disponibilidade"
        @quartos = @quartos.where(disponibilidade: search_query)
      when "preco_diaria"
        @quartos = @quartos.where('preco_diaria LIKE ?', "%#{search_query}%")
      when "descricao"
        @quartos = @quartos.where('descricao LIKE ?', "%#{search_query}%")
      when "quantidade_de_hospedes"
        @quartos = @quartos.where('quantidade_de_hospedes = ?', search_query)
      end
    end
  end

  def historico_hospedagem
    @quarto = Quarto.find(params[:id])
    @reservas_passadas = @quarto.reservas.where('data_de_saida < ?', Date.today)
    @reservas_futuras = @quarto.reservas.where('data_de_entrada > ?', Date.today)
  end

  # GET /quartos/1 or /quartos/1.json
  def show
  end

  # GET /quartos/new
  def new
    @quarto = Quarto.new
  end

  # GET /quartos/1/edit
  def edit
  end

  # POST /quartos or /quartos.json
  def create
    @quarto = Quarto.new(quarto_params)

    respond_to do |format|
      if @quarto.save
        format.html { redirect_to quarto_url(@quarto), notice: "Quarto criado com sucesso." }
        format.json { render :show, status: :created, location: @quarto }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @quarto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /quartos/1 or /quartos/1.json
  def update
    respond_to do |format|
      if @quarto.update(quarto_params)
        format.html { redirect_to quarto_url(@quarto), notice: "Quarto atualizado com sucesso." }
        format.json { render :show, status: :ok, location: @quarto }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @quarto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quartos/1 or /quartos/1.json
  def destroy
    reservas = @quarto.reservas

    # Excluir as reservas associadas ao quarto
    reservas.each do |reserva|
      reserva.destroy
    end
    @quarto.destroy

    respond_to do |format|
      format.html { redirect_to quartos_url, notice: "Quarto destruído com sucesso." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quarto
      @quarto = Quarto.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def quarto_params
      params.require(:quarto).permit(:numero, :tipo, :disponibilidade, :preco_diaria, :descricao, :quantidade_de_hospedes)
    end
end
