class Quarto < ApplicationRecord
  has_many :reservas, dependent: :destroy
  has_many :clientes, through: :reservas

  validates :numero, presence: { message: "não pode estar em branco." }, uniqueness: { message: "de quarto já registrado." }, numericality: { only_integer: true, message: "deve ter apenas dígitos numéricos." }
  validates :tipo, presence: { message: "não pode estar em branco." }, inclusion: { in: ['Quarto Padrão', 'Quarto Familiar', 'Quarto de Luxo', 'Suíte Master', 'Suíte Presidencial'], message: "deve ser uma opção válida." }
  validates :disponibilidade, inclusion: { in: [true, false], message: "deve ser uma opção válida." }
  validates :preco_diaria, presence: { message: "não pode estar em branco." }, numericality: { greater_than: 0, message: "deve ter um valor acima de zero." }
  validates :descricao, length: { maximum: 128, message: "deve ter, no máximo, 128 caracteres." }, allow_blank: true
  validates :quantidade_de_hospedes, presence: { message: "não pode estar em branco." }, numericality: { greater_than: 0, message: "deve ter um valor acima de zero." }
  validate :verificar_conflito_de_tipos, on: :create

  def verificar_conflito_de_tipos
    case tipo
    when 'Quarto Padrão'
      validar_quantidade_de_hospedes(1, 2) # Permitindo de 1 à 2 Hóspedes
    when 'Quarto Familiar'
      validar_quantidade_de_hospedes(4, 8) # Permitindo de 4 à 8 Hóspedes
    when 'Quarto de Luxo'
      validar_quantidade_de_hospedes(1, 4) # Permitindo de 1 à 4 Hóspedes
    when 'Suíte Master'
      validar_quantidade_de_hospedes(1, 8) # Permitindo de 1 à 8 Hóspedes
    when 'Suíte Presidencial'
      validar_quantidade_de_hospedes(1, 20) # Permitindo de 1 à 20 Hóspedes
    end
  end

  def validar_quantidade_de_hospedes(min, max)
    if tipo.present? && quantidade_de_hospedes.present?
      unless (quantidade_de_hospedes.between?(min, max))
        errors.add(:quantidade_de_hospedes, " para um(a) #{tipo} deve estar entre #{min} e #{max} hóspede(s).")
      end
    end
  end
end
