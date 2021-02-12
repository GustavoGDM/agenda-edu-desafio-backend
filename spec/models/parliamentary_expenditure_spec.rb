require 'rails_helper'

RSpec.describe ParliamentaryExpenditure, type: :model do
  it "is valid with valid attributes" do
    parliamentary_expenditure = create(:parliamentary_expenditure)
    expect(parliamentary_expenditure).to be_valid
  end

  it "is invalid without datEmissao" do
    parliamentary_expenditure = build(:parliamentary_expenditure, datEmissao: nil)
    parliamentary_expenditure.valid?
    expect(parliamentary_expenditure.errors[:datEmissao]).to include("can't be blank")
  end
  
  it "is invalid without txtFornecedor" do
    parliamentary_expenditure = build(:parliamentary_expenditure, txtFornecedor: nil)
    parliamentary_expenditure.valid?
    expect(parliamentary_expenditure.errors[:txtFornecedor]).to include("can't be blank")
  end
  
  it "is invalid without vlrLiquido" do
    parliamentary_expenditure = build(:parliamentary_expenditure, vlrLiquido: nil)
    parliamentary_expenditure.valid?
    expect(parliamentary_expenditure.errors[:vlrLiquido]).to include("can't be blank")
  end

  it "is invalid without ideDocumento" do
    parliamentary_expenditure = build(:parliamentary_expenditure, ideDocumento: nil)
    parliamentary_expenditure.valid?
    expect(parliamentary_expenditure.errors[:ideDocumento]).to include("can't be blank")
  end

  it "is invalid without urlDocumento" do
    parliamentary_expenditure = build(:parliamentary_expenditure, urlDocumento: nil)
    parliamentary_expenditure.valid?
    expect(parliamentary_expenditure.errors[:urlDocumento]).to include("can't be blank")
  end

  it "belogs to parliamentarian" do
    association = ParliamentaryExpenditure.reflect_on_association(:parliamentarian).macro
    expect(association).to eq(:belongs_to)
  end
  
end
