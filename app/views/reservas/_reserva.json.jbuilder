json.extract! reserva, :id, :cliente_id, :quarto_id, :data_de_entrada, :data_de_saida, :custo, :created_at, :updated_at
json.url reserva_url(reserva, format: :json)
