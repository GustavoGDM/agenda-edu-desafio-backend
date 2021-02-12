FactoryBot.define do
  factory :parliamentarian do
    name { Faker::Name.name }
    cpf { Faker::IDNumber.brazilian_citizen_number }
    ideCadastro { rand(1...9999) }
    sgPartido { "PNI" }
    upload_file
  end
end
