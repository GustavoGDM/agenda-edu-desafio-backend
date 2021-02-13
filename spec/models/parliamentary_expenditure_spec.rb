require 'rails_helper'

RSpec.describe ParliamentaryExpenditure, type: :model do
  it "is valid with valid attributes" do
    parliamentary_expenditure = create(:parliamentary_expenditure)
    expect(parliamentary_expenditure).to be_valid
  end

  it "belogs to parliamentarian" do
    association = ParliamentaryExpenditure.reflect_on_association(:parliamentarian).macro
    expect(association).to eq(:belongs_to)
  end
  
end
