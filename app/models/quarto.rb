class Quarto < ApplicationRecord
  has_many :reservas, dependent: :destroy
  has_many :clientes, through: :reservas

  validates :numero, presence: { message: "não pode estar em branco." }, uniqueness: { message: "de quarto já registrado." }, numericality: {only_integer:  true, message: "deve ter apenas dígitos numéricos." }
  validates :tipo, presence: { message: "não pode estar em branco." }, inclusion: { in: ['Quarto Padrão', 'Quarto Familiar', 'Quarto de Luxo', 'Suíte Padrão', 'Suíte Presidencial'], message: "deve ser uma opção válida."}
  validates :disponibilidade, inclusion: { in: [true, false], message: "deve ser uma opção válida."}
  validates :preco_diaria, presence: { message: "não pode estar em branco." }, numericality: { greater_than: 0, message: "deve ter um valor acima de zero." }
  validates :descricao, length: { maximum: 128, message:"deve ter, no máximo, 128 caracteres." }, allow_blank: true

end
