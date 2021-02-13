require 'rails_helper'

RSpec.describe UploadFile, type: :model do
  it "is valid with valid attributes" do
    upload_file = create(:upload_file)
    expect(upload_file).to be_valid
  end
  
  it "is invalid without name" do
    upload_file = build(:upload_file, name: nil)
    upload_file.valid?
    expect(upload_file.errors[:name]).to include("can't be blank")
  end

  it "has many parliamentarian" do
    association = UploadFile.reflect_on_association(:parliamentarians).macro
    expect(association).to eq(:has_many)
  end
end
