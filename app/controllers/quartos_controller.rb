class QuartosController < ApplicationController
  before_action :set_quarto, only: %i[ show edit update destroy ]

  # GET /quartos or /quartos.json
  def index
    @quartos = Quarto.all
    @quartos = buscar_quartos(params[:attribute], params[:search])
  end

  # GET /quartos/1 or /quartos/1.json
  def show
    @quarto = Quarto.find(params[:id])
    @reservas_passadas = @quarto.reservas.where('data_de_saida < ?', Time.zone.today)
    @reservas_futuras = @quarto.reservas.where('data_de_entrada > ?', Time.zone.today)
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

    def buscar_quartos(attribute, search)
      quartos_query = Quarto.all

      case attribute
      when "numero"
        quartos_query = quartos_query.where('numero LIKE ?', "%#{search}%")
      when "tipo"
        quartos_query = quartos_query.where('tipo LIKE ?', "%#{search}%")
      when "disponibilidade"
        quartos_query = quartos_query.where(disponibilidade: search)
      when "preco_diaria"
        quartos_query = quartos_query.where('preco_diaria LIKE ?', "%#{search}%")
      when "descricao"
        quartos_query = quartos_query.where('descricao LIKE ?', "%#{search}%")
      when "quantidade_de_hospedes"
        quartos_query = quartos_query.where('quantidade_de_hospedes = ?', search)
      end

      quartos_query
    end
end
