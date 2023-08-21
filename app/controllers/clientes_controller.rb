class ClientesController < ApplicationController
  before_action :authenticate_administrador!
  before_action :set_cliente, only: %i[ show edit update destroy ]

  # GET /clientes or /clientes.json
  def index
    @clientes = buscar_clientes(params[:atributo], params[:busca])
  end

  def historico
    @cliente = Cliente.find(params[:id])
    @reservas = @cliente.reservas
  end

  # GET /clientes/1 or /clientes/1.json
  def show
    @cliente = Cliente.find(params[:id])
    @reservas = @cliente.reservas
  end

  # GET /clientes/new
  def new
    @cliente = Cliente.new
  end

  # GET /clientes/1/edit
  def edit
  end

  # POST /clientes or /clientes.json
  def create
    @cliente = Cliente.new(cliente_params)

    respond_to do |format|
      if @cliente.save
        format.html { redirect_to cliente_url(@cliente), notice: "Cliente criado com sucesso." }
        format.json { render :show, status: :created, location: @cliente }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @cliente.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clientes/1 or /clientes/1.json
  def update
    respond_to do |format|
      if @cliente.update(cliente_params)
        format.html { redirect_to cliente_url(@cliente), notice: "Cliente atualizado com sucesso." }
        format.json { render :show, status: :ok, location: @cliente }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @cliente.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clientes/1 or /clientes/1.json
  def destroy
    # Obtendo as reservas do cliente antes de excluí-lo
    reservas = @cliente.reservas
    reservas.each do |reserva|
      reserva.destroy
    end
    @cliente.destroy

    respond_to do |format|
      format.html { redirect_to clientes_url, notice: "Cliente destruído com sucesso." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_cliente
    @cliente = Cliente.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def cliente_params
    params.require(:cliente).permit(:cpf, :nome, :email, :telefone)
  end

  def buscar_clientes(atributo, busca)
    case atributo
    when "nome"
      return Cliente.where('UPPER(nome) LIKE ?', "%#{busca.upcase}%")
    when "cpf"
      busca_formatada = busca.gsub(/\D/, '')
      busca_formatada_com_traco = "#{busca_formatada[0..2]}.#{busca_formatada[3..5]}.#{busca_formatada[6..8]}-#{busca_formatada[9..10]}"
      return Cliente.where('cpf LIKE ? OR REPLACE(cpf, ".", "") LIKE ?', "%#{busca_formatada_com_traco}%", "%#{busca_formatada}%")
    when "email"
      return Cliente.where('UPPER(email) LIKE ?', "%#{busca.upcase}%")
    else
      return Cliente.all
    end
  end
end
