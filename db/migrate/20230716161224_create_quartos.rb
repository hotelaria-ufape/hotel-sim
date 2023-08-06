class CreateQuartos < ActiveRecord::Migration[7.0]
  def change
    create_table :quartos do |t|
      t.integer :numero
      t.string :tipo
      t.boolean :disponibilidade
      t.decimal :preco_diaria
      t.text :descricao
      t.decimal :quantidade_de_hospedes

      t.timestamps
    end
  end
end
