require 'rails_helper'

RSpec.describe Parliamentarian, type: :model do
  it "is valid with valid attributes" do
    parliamentarian = create(:parliamentarian)
    expect(parliamentarian).to be_valid
  end

  it "is invalid without name" do
    parliamentarian = build(:parliamentarian, name: nil)
    parliamentarian.valid?
    expect(parliamentarian.errors[:name]).to include("can't be blank")
  end

  it "is invalid without cpf" do
    parliamentarian = build(:parliamentarian, cpf: nil)
    parliamentarian.valid?
    expect(parliamentarian.errors[:cpf]).to include("can't be blank")
  end

  it "is invalid without ideCadastro" do
    parliamentarian = build(:parliamentarian, ideCadastro: nil)
    parliamentarian.valid?
    expect(parliamentarian.errors[:ideCadastro]).to include("can't be blank")
  end

  it "is invalid without sgPartido" do
    parliamentarian = build(:parliamentarian, sgPartido: nil)
    parliamentarian.valid?
    expect(parliamentarian.errors[:sgPartido]).to include("can't be blank")
  end

  it "belogs to upload_file" do
    association = Parliamentarian.reflect_on_association(:upload_file).macro
    expect(association).to eq(:belongs_to)
  end

  it "has many parliamentary expenditure" do
    association = Parliamentarian.reflect_on_association(:parliamentary_expenditures).macro
    expect(association).to eq(:has_many)
  end
  
end
