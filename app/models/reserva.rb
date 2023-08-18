class Reserva < ApplicationRecord
  belongs_to :cliente
  belongs_to :quarto

  validates :cliente_id, presence: { message: "não pode estar em branco." }
  validates :quarto_id, presence: { message: "não pode estar em branco." }
  validates :data_de_entrada, presence: { message: "não pode estar em branco." }
  validates :data_de_saida, presence: { message: "não pode estar em branco." }
  validates :custo, presence: { message: "não pode estar em branco." }, numericality: { greater_than: 0, message: "deve ser acima de zero." }
  validate :data_entrada
  validate :data_saida
  validate :horas_de_diferenca_maior_que_6
  validate :verificar_conflito_de_datas
  validate :verificar_custo_valido

  private

  def data_entrada
    if data_de_entrada.present? && (data_de_entrada <= ((Date.current + 1) - 1.minute))
      errors.add(:data_de_entrada, "inválida. (veja se a data de entrada é posterior à data de hoje)")
    end
  end

  def data_saida
    if data_de_saida.present? && (data_de_saida <= ((Date.current + 1) - 1.minute))
      errors.add(:data_de_saida, "inválida. (veja se a data de saída é posterior à data de entrada e possui uma diferença acima de 6 horas de estadia)")
    end
  end

  def horas_de_diferenca_maior_que_6
    return if data_de_saida.blank? || data_de_entrada.blank?

    diferenca_horas = (data_de_saida - data_de_entrada) / 1.hour
    errors.add(:data_de_saida, "deve ser marcada pelo menos para 6 horas após a data de entrada.") if diferenca_horas < 6
  end

  def verificar_conflito_de_datas
    if cliente_id.present? && quarto_id.present? && data_de_entrada.present? && data_de_saida.present?
      conflito_reserva = Reserva.where(quarto_id: quarto_id)
                                .where("(data_de_entrada BETWEEN ? AND ?) OR (data_de_saida BETWEEN ? AND ?)", data_de_entrada, data_de_saida, data_de_entrada, data_de_saida)
                                .where.not(id: id) # Ignora a reserva atual
                                .first

      if conflito_reserva && conflito_reserva.cliente_id != cliente_id
        periodo_conflito = "#{conflito_reserva.data_de_entrada.strftime('%d/%m/%Y das %H:%M')} até #{conflito_reserva.data_de_saida.strftime('%d/%m/%Y às %H:%M')}"
        errors.add(:base, "Este quarto já está reservado para #{Cliente.find(cliente_id).nome} pelo período de #{periodo_conflito}.")
      end
    end
  end

  def verificar_custo_valido
    if quarto_id.present? && data_de_entrada.present? && data_de_saida.present? && custo.present?
      valorDoQuarto = Quarto.find(quarto_id).preco_diaria
      diferencaEmMinutos = ((data_de_saida - data_de_entrada) / 60).to_i
      custoTotal = (valorDoQuarto / 1440) * diferencaEmMinutos
      custoEsperado = format('%.2f', custoTotal)
      if format('%.2f', custo) != custoEsperado
        errors.add(:custo, "inserido é inválido (custo atual #{format('%.2f', custo)} diferente de R$#{custoEsperado}) dado o quarto #{quarto_id} e o período de tempo #{data_de_entrada} e #{data_de_saida}.")
      end
    end
  end
end