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

  private

  def data_entrada
    if data_de_entrada.present? && (data_de_entrada <= Date.today)
      errors.add(:data_de_entrada, "inválida. (veja se a data de entrada é posterior à data de hoje)")
    end
  end

  def data_saida
    if data_de_saida.present? && data_de_saida <= Date.today && data_de_saida <= data_de_entrada && ((data_de_saida - data_de_entrada) / 1.hour).to_i <= 6
      errors.add(:data_de_saida, "inválida. (veja se a data de saída é posterior à data de entrada e possui uma diferença acima de 6 horas de estadia)")
    end
  end
end
