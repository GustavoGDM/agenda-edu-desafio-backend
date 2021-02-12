FactoryBot.define do
  factory :parliamentary_expenditure do
    datEmissao { Faker::Date.between(from: 10.years.ago, to: Date.today) }
    txtFornecedor { Faker::Company.name }
    vlrLiquido { rand(1.0...9999.99) }
    ideDocumento { rand(1...9999) }
    urlDocumento { Faker::Internet.url }
    parliamentarian
  end
end
