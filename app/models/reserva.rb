class Reserva < ApplicationRecord
  belongs_to :cliente
  belongs_to :quarto

  validates :cliente_id, presence: true
  validates :quarto_id, presence: true
  validates :data_de_entrada, presence: true
  validates :data_de_saida, presence: true
  validate :data_entrada
  validate :data_saida

  before_destroy :marcar_quarto_como_disponivel

  private

  def marcar_quarto_como_disponivel
    quarto.update(disponibilidade: true)
  end

  def data_entrada
    if data_de_entrada.present? && data_de_entrada < Date.today
      errors.add(:data_de_entrada, "Não pode ser no passado")
    end
  end

  def data_saida
    if data_de_saida.present? && data_de_saida < Date.today
      errors.add(:data_de_saida, "Data inválida")
    end
  end

end
