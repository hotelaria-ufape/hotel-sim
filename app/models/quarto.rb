class Quarto < ApplicationRecord
  has_many :reservas, dependent: :destroy

  validates :numero, presence: { message: "não pode estar em branco." }, uniqueness: { message: "de quarto já registrado." }, numericality: {only_integer:  true, message: "deve ter apenas dígitos numéricos." }
  validates :tipo, presence: { message: "não pode estar em branco." }, inclusion: { in: ['Quarto Padrão', 'Quarto Familiar', 'Quarto de Luxo', 'Suíte Padrão', 'Suíte Presidencial'], message: "deve ser uma opção válida."}
  validates :disponibilidade, inclusion: { in: [true, false], message: "deve ser uma opção válida."}
  validates :preco_diaria, presence: { message: "não pode estar em branco." }, numericality: { greater_than: 0, message: "deve ter um valor acima de zero." }
  validates :descricao, presence: { message: "não pode estar em branco." }, length: {in: 5..256, message: "deve ter entre 5 e 255 caracteres." }

  scope :disponibilidade, -> { where(disponibilidade: true) }

end
