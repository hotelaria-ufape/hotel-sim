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
  validate :verificar_conflito_de_datas, on: :create

  private

  def data_entrada
    if data_de_entrada.present? && (data_de_entrada <= Date.today)
      errors.add(:data_de_entrada, "inválida. (veja se a data de entrada é posterior à data de hoje)")
    end
  end

  def data_saida
    if data_de_saida.present? && data_de_saida <= Date.today
      errors.add(:data_de_saida, "inválida. (veja se a data de saída é posterior à data de entrada e possui uma diferença acima de 6 horas de estadia)")
    end
  end

  def horas_de_diferenca_maior_que_6
    return if data_de_saida.blank? || data_de_entrada.blank?

    diferenca_horas = (data_de_saida - data_de_entrada) / 1.hour
    errors.add(:data_de_saida, "deve ser marcada pelo menos para 6 horas após a data de entrada.") if diferenca_horas < 6
  end

  def verificar_conflito_de_datas
    if quarto_id.present? && data_de_entrada.present? && data_de_saida.present?
      conflito_reserva = Reserva.where(quarto_id: quarto_id)
                                .where("(data_de_entrada BETWEEN ? AND ?) OR (data_de_saida BETWEEN ? AND ?)", data_de_entrada, data_de_saida, data_de_entrada, data_de_saida)
                                .first
      if conflito_reserva
        periodo_conflito = "#{conflito_reserva.data_de_entrada.strftime('%d/%m/%Y às %H:%M')} até #{conflito_reserva.data_de_saida.strftime('%d/%m/%Y às %H:%M')}"
        errors.add(:base, "Este quarto já está reservado para o período de #{periodo_conflito}.")
      end
    end
  end
end
