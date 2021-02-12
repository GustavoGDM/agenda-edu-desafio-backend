class CreateParliamentaryExpenditures < ActiveRecord::Migration[6.0]
  def change
    create_table :parliamentary_expenditures do |t|
      t.date :datEmissao
      t.string :txtFornecedor
      t.float :vlrLiquido
      t.references :parliamentarian, null: false, foreign_key: true
      t.timestamps
    end
  end
end
