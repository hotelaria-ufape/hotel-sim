require 'cpf_cnpj'

class Cliente < ApplicationRecord
  has_many :reservas, dependent: :destroy

  validates :nome, presence: true, length: {in: 5..40}
  validates :telefone, presence: true, uniqueness: true, format: { with: /\A\d{2}\d{5}-\d{4}\z/, message: "formato de telefone de ser ddd xxxxx-xxxx" }, length: {in: 12..13}
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP}
  validates :cpf, presence: true, uniqueness: true
  validate :cpf_valido

  before_validation :formatar_cpf

  def cpf_valido
    if cpf.present? && !CPF.valid?(cpf)
      errors.add(:cpf, "formato ou número errado")
    end
  end

  def formatar_cpf
    self.cpf = CPF.new(cpf).formatted if cpf.present?
  end

end
