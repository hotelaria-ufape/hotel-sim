class CreateReservas < ActiveRecord::Migration[7.0]
  def change
    create_table :reservas do |t|
      t.references :cliente, null: false, foreign_key: true
      t.references :quarto, null: false, foreign_key: true
      t.date :data_de_entrada
      t.date :data_de_saida
      t.decimal :custo

      t.timestamps
    end
  end
end
