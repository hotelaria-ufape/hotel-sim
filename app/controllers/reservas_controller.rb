class ReservasController < ApplicationController
  before_action :authenticate_administrador!
  before_action :set_reserva, only: %i[ show edit update destroy ]

  # GET /reservas or /reservas.json
  def index
    @reservas = buscar_reservas(params[:atributo])
  end

  # GET /reservas/1 or /reservas/1.json
  def show
  end

  # GET /reservas/new
  def new
    @reserva = Reserva.new(cliente_id: params[:cliente_id], quarto_id: params[:quarto_id])
  end

  def get_custo
    quarto = Quarto.find(params[:quarto_id])
    custo = quarto.preco_diaria
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

  def buscar_reservas(attribute)
    busca = Reserva.all
    case attribute
    when "data"
      if params[:data_inicial].present? && params[:data_final].present?
        data_de_inicio = DateTime.parse(params[:data_inicial])
        data_de_fim = DateTime.parse(params[:data_final])
        busca = Reserva.where("(data_de_entrada BETWEEN ? AND ?) OR (data_de_saida BETWEEN ? AND ?)", data_de_inicio , data_de_fim, data_de_inicio, data_de_fim)
      elsif !params[:data_inicial].present? && params[:data_final].present?
        if params[:data_final] > DateTime.now
          data_de_inicio = DateTime.now
          data_de_fim = DateTime.parse(params[:data_final])
          busca = Reserva.where("(data_de_entrada BETWEEN ? AND ?) OR (data_de_saida BETWEEN ? AND ?)", data_de_inicio , data_de_fim, data_de_inicio, data_de_fim)
        end
      elsif params[:data_inicial].present? && !params[:data_final].present?
        if params[:data_inicial] < DateTime.now
          data_de_inicio = DateTime.parse(params[:data_inicial])
          data_de_fim = DateTime.now
          busca = Reserva.where("(data_de_entrada BETWEEN ? AND ?) OR (data_de_saida BETWEEN ? AND ?)", data_de_inicio , data_de_fim, data_de_inicio, data_de_fim)
        end
      end
    when "custo"
      if params[:custo_minimo].present? && params[:custo_maximo].present?
        min_cost = params[:custo_minimo].to_f
        max_cost = params[:custo_maximo].to_f
        busca = Reserva.where(custo: min_cost..max_cost)
      end
    when "cliente"
      if params[:cliente_id].present?
        busca = Reserva.where(cliente_id: params[:cliente_id])
      end
    end
    return busca
  end

end