# Table name: upload_files
#
# id:                   integer
# name:                 string

class UploadFile < ApplicationRecord
  has_many :parliamentarians
  has_many :parliamentary_expenditures, through: :parliamentarians

  validates :name, presence: true
end
