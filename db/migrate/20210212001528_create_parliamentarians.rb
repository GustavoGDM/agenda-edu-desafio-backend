class CreateParliamentarians < ActiveRecord::Migration[6.0]
  def change
    create_table :parliamentarians do |t|
      t.string :name
      t.string :cpf
      t.integer :ideCadastro
      t.string :sgPartido
      t.references :upload_file, null: false, foreign_key: true
      t.timestamps
    end
  end
end
