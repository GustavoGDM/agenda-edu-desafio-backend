# Table name: upload_files
#
# id:                   integer
# name:                 string

class UploadFile < ApplicationRecord
  has_many :parliamentarians

  validates :name, presence: true
end
