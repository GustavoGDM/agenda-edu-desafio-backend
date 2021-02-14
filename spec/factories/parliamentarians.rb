FactoryBot.define do
  factory :parliamentarian do
    txNomeParlamentar { Faker::Name.name }
    cpf { Faker::IDNumber.brazilian_citizen_number }
    ideCadastro { rand(1...9999) }
    sgPartido { "PNI" }
    upload_file
    
    factory :parliamentarian_with_expenditures do
      after(:create) do |parliamentarian|
        create_list(:parliamentary_expenditure, rand(1...20), parliamentarian: parliamentarian)
      end
    end

  end
end
