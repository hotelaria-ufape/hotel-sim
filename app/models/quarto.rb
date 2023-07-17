class Quarto < ApplicationRecord
  has_many :reservas, dependent: :destroy

  validates :numero, presence: true, uniqueness: true, numericality: {only_integer:  true }
  validates :tipo, presence: true, length: {in: 4..10}
  validates :disponibilidade, inclusion: { in: [true, false]}
  validates :preco_diaria, presence: true, numericality: { greater_than: 0 }
  validates :descricao, presence: true, length: {in: 4..50}
  validates :preco_diaria, presence: true

  scope :disponibilidade, -> { where(disponibilidade: true) }

end
