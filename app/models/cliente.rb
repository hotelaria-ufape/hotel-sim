require 'cpf_cnpj'

class Cliente < ApplicationRecord
  has_many :reservas, dependent: :destroy
  has_many :quartos, through: :reservas

  validates :nome, presence: { message: "não pode estar em branco." }, length: {in: 5..256, message: "deve ter entre 5 e 255 caracteres."}
  validates :telefone, presence: { message: "não pode estar em branco." }, length: { is: 11, message: "deve ter 11 dígitos. (DDD+Número. Ex: 87912345678)" }
  validates :email, presence: { message: "não pode estar em branco." }, uniqueness: { message: "informado não é valido." }, format: { with: URI::MailTo::EMAIL_REGEXP, message: "informado não é valido."}
  validates :cpf, presence: { message: "não pode estar em branco." }, uniqueness: { message: "informado não é valido." }
  validate :cpf_valido

  before_validation :formatar_cpf

  def cpf_valido
    if cpf.present? && !CPF.valid?(cpf)
      errors.add(:cpf, "informado não é valido.")
    end
  end

  def formatar_cpf
    self.cpf = CPF.new(cpf).formatted if cpf.present?
  end

end
