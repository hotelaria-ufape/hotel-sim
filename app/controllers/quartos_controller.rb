class QuartosController < ApplicationController
  before_action :authenticate_administrador!, except: [:index]
  before_action :set_quarto, only: %i[ show edit update destroy ]

  # GET /quartos or /quartos.json
  def index
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

  def buscar_quartos(atributo, buscar)
    case atributo
    when "numero"
      Quarto.where('numero LIKE ?', "%#{buscar}%")
    when "tipo"
      Quarto.where('tipo LIKE ?', "%#{buscar}%")
    when "disponibilidade"
      Quarto.where(disponibilidade: buscar)
    when "preco_diaria"
      Quarto.where('preco_diaria LIKE ?', "%#{buscar}%")
    when "quantidade_de_hospedes"
      Quarto.where(quantidade_de_hospedes: buscar)
    else
      Quarto.all
    end
  end

end