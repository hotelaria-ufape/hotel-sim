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

  def self.search(attribute, search)
    if search
      case attribute
      when "nome"
        where('UPPER(nome) LIKE ?', "%#{search.upcase}%")
      when "cpf"
        formatted_search = search.gsub(/\D/, '')
        formatted_search_with_dash = "#{formatted_search[0..2]}.#{formatted_search[3..5]}.#{formatted_search[6..8]}-#{formatted_search[9..10]}"
        where('cpf LIKE ? OR REPLACE(cpf, ".", "") LIKE ?', "%#{formatted_search_with_dash}%", "%#{formatted_search}%")
      when "email"
        where('UPPER(email) LIKE ?', "%#{search.upcase}%")
      else
        all
      end
    else
      all
    end
  end

end
