class Reserva < ApplicationRecord
  belongs_to :cliente
  belongs_to :quarto
end
